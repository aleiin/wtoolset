import 'package:flutter/material.dart';

class MusicPlay extends StatefulWidget {
  const MusicPlay({
    this.controller,
    this.duration,
    Key? key,
  }) : super(key: key);

  /// 控制器
  final MusicPlayController? controller;

  /// 时长
  final Duration? duration;

  @override
  _MusicPlayState createState() => _MusicPlayState();
}

class _MusicPlayState extends State<MusicPlay>
    with SingleTickerProviderStateMixin {
  /// 动画控制器
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(seconds: 5),
    );

    if (widget.controller?.animating ?? false) {
      _controller!.repeat();
    }

    widget.controller?.addListener((animating) {
      if (animating) {
        _controller!.repeat();
      } else {
        _controller!.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller!,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(100),
          color: Colors.deepOrangeAccent,
        ),
        child: const Icon(
          Icons.music_note,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}

class MusicPlayController {
  /// 是否启动动画
  bool animating;

  /// 有参方法
  Function(bool animating)? listener;

  /// 无参方法
  Function()? voidListener;

  /// 构造函数
  MusicPlayController({this.animating = true});

  /// 监听有参方法
  void addListener(Function(bool animating)? listener) {
    this.listener = listener;
  }

  /// 监听无参方法
  void addVoidListener(Function() listener) {
    voidListener = listener;
  }

  /// 开始
  void play() {
    animating = true;
    if (listener != null) {
      listener!(animating);
    }

    if (voidListener != null) {
      voidListener!();
    }
  }

  /// 结束
  void stop() {
    animating = false;
    if (listener != null) {
      listener!(animating);
    }
    if (voidListener != null) {
      voidListener!();
    }
  }

  /// 销毁
  void dispose() {
    animating = false;
  }
}
