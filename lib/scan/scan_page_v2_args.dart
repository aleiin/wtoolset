import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPageV2Args {
  const ScanPageV2Args({
    this.hint,
    this.onCallBack,
  });

  /// 提示语
  final String? hint;

  ///
  final Function(BarcodeCapture barcodeCapture)? onCallBack;
}
