import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart' as path_lib;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:universal_io/io.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class RecordingDialog extends StatefulWidget {
  const RecordingDialog({
    super.key,
  });

  @override
  RecordingDialogState createState() => RecordingDialogState();
}

class RecordingDialogState extends State<RecordingDialog> {
  Timer? _recorderSubscription;
  Duration _duration = Duration.zero;

  bool error = false;

  final _audioRecorder = AudioRecorder();
  final List<double> amplitudeTimeline = [];

  String? fileName;

  static const int bitRate = 64000;
  static const int samplingRate = 44100;

  Future<void> startRecording() async {
    try {
      final AudioEncoder codec =
          await _audioRecorder.isEncoderSupported(AudioEncoder.opus)
              ? AudioEncoder.opus
              : AudioEncoder.aacLc;

      fileName =
          'recording${DateTime.now().microsecondsSinceEpoch}.${codec.fileExtension}';

      String? path;

      final tempDir = await getTemporaryDirectory();
      path = path_lib.join(tempDir.path, fileName);

      final result = await _audioRecorder.hasPermission();

      if (result != true) {
        setState(() => error = true);
        return;
      }

      /// 防止锁屏
      await WakelockPlus.enable();

      await _audioRecorder.start(
        RecordConfig(
          bitRate: bitRate,
          sampleRate: samplingRate,
          numChannels: 1,
          autoGain: true,
          echoCancel: true,
          noiseSuppress: true,
          encoder: codec,
        ),
        path: path,
      );

      setState(() => _duration = Duration.zero);

      _recorderSubscription?.cancel();

      _recorderSubscription =
          Timer.periodic(const Duration(milliseconds: 100), (_) async {
        final Amplitude amplitude = await _audioRecorder.getAmplitude();

        var value = 100 + amplitude.current * 2;

        value = value < 1 ? 1 : value;

        amplitudeTimeline.add(value);

        setState(() {
          _duration += const Duration(milliseconds: 100);
        });
      });
    } catch (_) {
      setState(() => error = true);
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    startRecording();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _recorderSubscription?.cancel();
    _audioRecorder.stop();
    super.dispose();
  }

  void _stopAndSend() async {
    _recorderSubscription?.cancel();

    final String? path = await _audioRecorder.stop();

    if (path == null) throw ('Recording failed!');

    const int waveCount = 40;

    final int step = amplitudeTimeline.length < waveCount
        ? 1
        : (amplitudeTimeline.length / waveCount).round();

    final List<int> waveform = <int>[];

    for (int i = 0; i < amplitudeTimeline.length; i += step) {
      waveform.add((amplitudeTimeline[i] / 100 * 1024).round());
    }

    Navigator.of(context, rootNavigator: false).pop<RecordingResult>(
      RecordingResult(
        path: path,
        duration: _duration.inMilliseconds,
        waveform: waveform,
        fileName: fileName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const double maxDecibalWidth = 64.0;

    final time =
        '${_duration.inMinutes.toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}';

    final content = error
        ? const Text('哎呀出了点问题')
        : Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.red,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: amplitudeTimeline.reversed
                      .take(26)
                      .toList()
                      .reversed
                      .map((amplitude) {
                    return Container(
                      margin: const EdgeInsets.only(left: 2),
                      width: 4,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      height: maxDecibalWidth * (amplitude / 100),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 48,
                child: Text(time),
              ),
            ],
          );

    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoAlertDialog(
        content: content,
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context, rootNavigator: false).pop(),
            child: Text(
              '取消',
              style: TextStyle(
                color: theme.textTheme.bodyMedium?.color?.withAlpha(150),
              ),
            ),
          ),
          if (error != true)
            CupertinoDialogAction(
              onPressed: _stopAndSend,
              child: const Text('发送'),
            ),
        ],
      );
    }

    return AlertDialog(
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context, rootNavigator: false).pop(),
          child: Text(
            '取消',
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color?.withAlpha(150),
            ),
          ),
        ),
        if (error != true)
          TextButton(
            onPressed: _stopAndSend,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('发送'),
                SizedBox(width: 4),
                Icon(Icons.send_outlined, size: 15),
              ],
            ),
          ),
      ],
    );
  }
}

class RecordingResult {
  final String path;
  final int duration;
  final List<int> waveform;
  final String? fileName;

  const RecordingResult({
    required this.path,
    required this.duration,
    required this.waveform,
    required this.fileName,
  });
}

extension on AudioEncoder {
  String get fileExtension {
    switch (this) {
      case AudioEncoder.aacLc:
      case AudioEncoder.aacEld:
      case AudioEncoder.aacHe:
        return 'm4a';
      case AudioEncoder.opus:
        return 'ogg';
      case AudioEncoder.wav:
        return 'wav';
      case AudioEncoder.amrNb:
      case AudioEncoder.amrWb:
      case AudioEncoder.flac:
      case AudioEncoder.pcm16bits:
        throw UnsupportedError('Not yet used');
    }
  }
}
