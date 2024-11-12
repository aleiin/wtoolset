import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:wtoolset/utils/util/recording_dialog.dart';
import 'package:wtoolset/widget/custom_widget.dart';

class VoiceRecordingPage extends StatelessWidget {
  const VoiceRecordingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      titleLabel: '语音录制',
      body: Center(
        child: IconButton(
          onPressed: () {
            voiceMessageAction(context);
          },
          icon: Icon(
            Icons.mic,
            size: 30,
          ),
        ),
      ),
    );
  }

  /// 语音录制
  void voiceMessageAction(BuildContext context) async {
    if (await AudioRecorder().hasPermission() == false) return;

    final result = await showDialog<RecordingResult>(
      context: context,
      barrierDismissible: false,
      builder: (c) => const RecordingDialog(),
    );

    if (result == null) return;

    final audioFile = XFile(result.path);

    print('print 17:03: ${audioFile}');
  }
}
