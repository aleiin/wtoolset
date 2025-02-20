import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

///
class CustomImage {
  static const imgUrl =
      'https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2cf14be1919b4692aea2a151b04a76b7~tplv-k3u1fbpfcp-zoom-crop-mark:3024:3024:3024:1702.awebp?';

  ///
  static Widget network(
    String? src, {
    BorderRadius? borderRadius,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    if ((src ?? '').isEmpty) {
      return SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.image_outlined,
        ),
      );
    }

    return ExtendedImage.network(
      src!,
      fit: fit ?? BoxFit.fill,
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      shape: BoxShape.rectangle,
      cache: true,
      width: width,
      height: height,
    );
  }

  /// 截取首字母
  static Widget cutTheFirstLetter(
    String? src, {
    double? width,
    double fontSize = 24,
  }) {
    String str = 'B';

    if ((src ?? '').isNotEmpty) {
      str = src!.substring(0, 1).toUpperCase();
    }

    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        str,
        style: TextStyle(
          fontSize: fontSize,
          fontVariations: const [FontVariation.weight(400)],
        ),
      ),
    );
  }

  ///
  static Widget networkOrCutTheFirstLetter(
    String? src, {
    String? label,
    BorderRadius? borderRadius,
    double? width,
    double? height,
    double fontSize = 24,
  }) {
    if ((src ?? '').isNotEmpty) {
      return network(
        src,
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    }

    return cutTheFirstLetter(
      label,
      width: width,
      fontSize: fontSize,
    );
  }
}
