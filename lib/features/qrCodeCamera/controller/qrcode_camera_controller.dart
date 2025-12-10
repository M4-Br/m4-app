import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/pix/decode/repository/pix_decode_code_repository.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeCameraController extends BaseController {
  late MobileScannerController cameraController;

  bool isProcessing = false;

  @override
  void onInit() {
    super.onInit();
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: false,
    );
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  void toggleTorch() => cameraController.toggleTorch();

  void switchCamera() => cameraController.switchCamera();

  void stopCamera() => cameraController.stop();

  Future<void> onDetect(BarcodeCapture capture) async {
    if (isProcessing || isLoading.value) return;

    final List<Barcode> barcodes = capture.barcodes;

    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;

      if (code != null && code.isNotEmpty) {
        _processQrCode(code);
      }
    }
  }

  Future<void> _processQrCode(String code) async {
    isProcessing = true;

    try {
      HapticFeedback.mediumImpact();

      await executeSafe(() async {
        final result = await PixDecodeCodeRepository().decode(code);

        Get.toNamed(AppRoutes.pixDecode, arguments: {'qrCode': result});
      });
    } catch (e, s) {
      AppLogger.I().error('Camera Decode', e, s);
      ShowToaster.toasterInfo(
          message: 'Não foi possível ler o QR Code', isError: true);
      isProcessing = false;
    } finally {
      isLoading(false);
      if (!Get.isOverlaysOpen) {
        isProcessing = false;
      }
    }
  }
}
