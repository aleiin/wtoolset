import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wtoolset/draw/study/common/coordinate.dart';

import 'dart:ui' as ui;

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  late ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    // _image = await loadImageFromAssets('assets/images/x.png');
    _image = await loadImageFromAssets('assets/images/right_chat.png');
    setState(() {});
  }

  /// 读取assets中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPaint(_image),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class PaperPaint extends CustomPainter {
  late Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  late final ui.Image image;

  final Coordinate coordinate = Coordinate();

  PaperPaint(this.image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    // _drawImage(canvas);
    // _drawImageRect(canvas);
    // _drawImageNine(canvas);
    // _drawTextWithParagraph(canvas, TextAlign.end);
    // _drawTextPaintShowSize(canvas);
  }

  @override
  bool shouldRepaint(PaperPaint oldDelegate) => image != oldDelegate.image;

  /// 图片的绘制
  void _drawImage(Canvas canvas) {
    if (image != null) {
      canvas.drawImage(
          image, Offset(-image.width / 2, -image.height / 2), _paint);
    }
  }

  /// 图片域绘制
  void _drawImageRect(Canvas canvas) {
    if (image != null) {
      canvas.drawImageRect(
        image,
        Rect.fromCenter(
            center: Offset(image.width / 2, image.height / 2),
            width: 60,
            height: 60),
        Rect.fromLTRB(0, 0, 100, 100).translate(200, 0),
        _paint,
      );

      canvas.drawImageRect(
        image,
        Rect.fromCenter(
            center: Offset(image.width / 2, image.height / 2 - 60),
            width: 60,
            height: 60),
        Rect.fromLTRB(0, 0, 100, 100).translate(-280, -100),
        _paint,
      );

      canvas.drawImageRect(
        image,
        Rect.fromCenter(
            center: Offset(image.width / 2 + 60, image.height / 2),
            width: 60,
            height: 60),
        Rect.fromLTRB(0, 0, 100, 100).translate(-280, 50),
        _paint,
      );
    }
  }

  void _drawImageNine(Canvas canvas) {
    if (image != null) {
      canvas.drawImageNine(
        image,
        Rect.fromCenter(
          center: Offset(image.width / 2, image.height - 6.0),
          width: image.width - 20.0,
          height: 2.0,
        ),
        Rect.fromCenter(
          center: Offset(0, 0),
          width: 300,
          height: 120,
        ),
        _paint,
      );

      canvas.drawImageNine(
          image,
          Rect.fromCenter(
              center: Offset(image.width / 2, image.height - 6.0),
              width: image.width - 20.0,
              height: 2.0),
          Rect.fromCenter(
                  center: Offset(
                    0,
                    0,
                  ),
                  width: 100,
                  height: 50)
              .translate(250, 0),
          _paint);

      canvas.drawImageNine(
          image,
          Rect.fromCenter(
              center: Offset(image.width / 2, image.height - 6.0),
              width: image.width - 20.0,
              height: 2.0),
          Rect.fromCenter(
                  center: Offset(
                    0,
                    0,
                  ),
                  width: 80,
                  height: 250)
              .translate(-250, 0),
          _paint);
    }
  }

  /// drawParagraph绘制文字
  void _drawTextWithParagraph(Canvas canvas, TextAlign textAlign) {
    var builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: textAlign,
        fontSize: 40,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      ),
    );

    builder.pushStyle(
      ui.TextStyle(
          color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
    );

    builder.addText("Flutter weibin");
    ui.Paragraph paragraph = builder.build();

    paragraph.layout(
      ui.ParagraphConstraints(width: 300),
    );
    canvas.drawParagraph(paragraph, Offset.zero);
    canvas.drawRect(
      Rect.fromLTRB(0, 0, 300, 40),
      _paint..color = Colors.blue.withAlpha(33),
    );
  }

  void _drawTextPaintShowSize(Canvas canvas) {
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: "weibin is shadan",
        style: TextStyle(
          fontSize: 40,
          foreground: textPaint,
          // color: Colors.black,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    /// 进行布局
    textPainter.layout(maxWidth: 200);

    /// 尺寸必须在布局后获取
    Size size = textPainter.size;

    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height)
          .translate(-size.width / 2, -size.height / 2),
      _paint..color = Colors.blue.withAlpha(33),
    );
  }
}
