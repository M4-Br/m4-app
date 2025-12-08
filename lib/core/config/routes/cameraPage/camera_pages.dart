import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/bindings/barcode_camera_bindings.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/presentation/barcode_camera_page.dart';
import 'package:app_flutter_miban4/features/qrCodeCamera/bindings/qrcode_camera_bindings.dart';
import 'package:app_flutter_miban4/features/qrCodeCamera/presentation/qrcode_camera_page.dart';
import 'package:get/get.dart';

class CameraPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.pixQrCodeReader,
      page: () => const QrCodeCameraPage(),
      binding: QrCodeCameraBindings(),
    ),
    GetPage(
        name: AppRoutes.barcode,
        page: () => const BarcodeCameraPage(),
        binding: BarcodeCameraBindings())
  ];
}
