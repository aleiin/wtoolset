// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:wtoolset/scan/scan_page_v2_args.dart';
// import 'package:wtoolset/scan/scanner_error_widget.dart';
//
// class ScanPageV2 extends StatefulWidget {
//   const ScanPageV2({
//     Key? key,
//     this.args,
//   }) : super(key: key);
//
//   final ScanPageV2Args? args;
//
//   @override
//   State<ScanPageV2> createState() => _ScanPageV2State();
// }
//
// class _ScanPageV2State extends State<ScanPageV2> {
//   /// 只允许pop一次
//   bool isPop = true;
//
//   /// 控制器
//   final MobileScannerController controller = MobileScannerController(
//     detectionSpeed: DetectionSpeed.noDuplicates,
//   );
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   ///
//   void onBarcodeDetect(BarcodeCapture barcodeCapture) {
//     widget.args?.onCallBack?.call(barcodeCapture);
//
//     if (barcodeCapture.barcodes.isNotEmpty) {
//       final barcode = barcodeCapture.barcodes.last;
//
//       if ((barcodeCapture.barcodes.last.displayValue ?? barcode.rawValue ?? '')
//               .isNotEmpty &&
//           isPop) {
//         isPop = false;
//
//         Navigator.pop(context,
//             barcodeCapture.barcodes.last.displayValue ?? barcode.rawValue);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final scanWindow = Rect.fromCenter(
//       center: MediaQueryData.fromWindow(window).size.center(Offset.zero),
//       width: 200,
//       height: 200,
//     );
//
//     return Scaffold(
//       body: SizedBox(
//         width: double.infinity,
//         height: double.infinity,
//         child: Stack(
//           children: [
//             MobileScanner(
//               onDetect: onBarcodeDetect,
//               controller: controller,
//               scanWindow: scanWindow,
//               errorBuilder: (context, error, child) {
//                 return ScannerErrorWidget(error: error);
//               },
//               placeholderBuilder: (_, __) {
//                 return Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   alignment: Alignment.center,
//                   child: const CupertinoActivityIndicator(radius: 12),
//                 );
//               },
//             ),
//             Positioned(
//               left: 0,
//               top: 0,
//               right: 0,
//               bottom: 0,
//               child: CustomPaint(
//                 painter: ScannerOverlay(scanWindow: scanWindow),
//               ),
//             ),
//             Positioned(
//               left: 0,
//               top: 0,
//               right: 0,
//               bottom: MediaQueryData.fromWindow(window).viewPadding.bottom + 12,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AppBar(
//                     backgroundColor: Colors.transparent,
//                     elevation: 0,
//                     iconTheme: const IconThemeData(
//                       color: Colors.white,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Column(
//                       children: [
//                         Text(
//                           widget.args?.hint ?? '請掃描二維碼',
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         Container(
//                           // color: Colors.red,
//                           margin: const EdgeInsets.symmetric(vertical: 20),
//                           child: ValueListenableBuilder<TorchState>(
//                             valueListenable: controller.torchState,
//                             builder: (context, value, child) {
//                               final Color iconColor;
//
//                               switch (value) {
//                                 case TorchState.off:
//                                   iconColor = Colors.white;
//                                   break;
//                                 case TorchState.on:
//                                   iconColor = Colors.yellow;
//                                   break;
//                               }
//
//                               return Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.3),
//                                   borderRadius: BorderRadius.circular(100),
//                                 ),
//                                 child: IconButton(
//                                   onPressed: () => controller.toggleTorch(),
//                                   icon: Icon(
//                                     Icons.flashlight_on,
//                                     color: iconColor,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         ValueListenableBuilder<TorchState>(
//                           valueListenable: controller.torchState,
//                           builder: (context, value, child) {
//                             String label = '手電筒';
//
//                             switch (value) {
//                               case TorchState.off:
//                                 label = '打開手電筒';
//                                 break;
//                               case TorchState.on:
//                                 label = '關閉手電筒';
//                                 break;
//                             }
//
//                             return Text(
//                               label,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(color: Colors.white),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ScannerOverlay extends CustomPainter {
//   const ScannerOverlay({
//     required this.scanWindow,
//     this.borderRadius = 12,
//   });
//
//   ///
//   final Rect scanWindow;
//
//   ///
//   final double borderRadius;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Path backgroundPath = Path()
//       ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
//
//     final Path cutoutPath = Path()
//       ..addRRect(
//         RRect.fromRectAndCorners(
//           scanWindow,
//           topLeft: Radius.circular(borderRadius),
//           topRight: Radius.circular(borderRadius),
//           bottomLeft: Radius.circular(borderRadius),
//           bottomRight: Radius.circular(borderRadius),
//         ),
//       );
//
//     canvas.drawPath(
//       Path.combine(PathOperation.xor, backgroundPath, cutoutPath),
//       Paint()..color = Colors.black.withOpacity(0.5),
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
