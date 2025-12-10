import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/repository/barcode_repository.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeCameraController extends BaseController {
  late MobileScannerController cameraController;
  bool isProcessing = false;

  @override
  void onInit() {
    super.onInit();
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: false,
    );
    _setLandscape();
  }

  @override
  void onClose() {
    _setPortrait();
    cameraController.dispose();
    super.onClose();
  }

  void toggleTorch() => cameraController.toggleTorch();
  void switchCamera() => cameraController.switchCamera();

  Future<void> onDetect(BarcodeCapture capture) async {
    if (isProcessing || isLoading.value) return;

    final List<Barcode> barcodes = capture.barcodes;

    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;

      if (code != null && code.isNotEmpty) {
        final cleanCode = code.replaceAll(RegExp(r'[^0-9]'), '');

        if (cleanCode.length < 44) {
          return;
        }

        _processBarcode(code);
      }
    }
  }

  void manualCode() async {
    await _setPortrait();

    await Get.toNamed(AppRoutes.barcodeManual);

    _setLandscape();
  }

  Future<void> _setLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<void> _setPortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> _processBarcode(String code) async {
    isProcessing = true;
    isLoading(true);

    try {
      HapticFeedback.mediumImpact();

      AppLogger.I().info('Barcode lido: $code');

      final result = await BarcodeRepository().decodeBarcode(code);

      if (result.success == true) {
        await _setPortrait();

        Get.toNamed(AppRoutes.barcodeConfirmPayment, arguments: result);
      }
    } catch (e, s) {
      AppLogger.I().error('Barcode Decode', e, s);
      ShowToaster.toasterInfo(message: 'Erro ao ler código', isError: true);
      isProcessing = false;
    } finally {
      isLoading(false);
      if (!Get.isOverlaysOpen) {
        isProcessing = false;
      }
    }
  }
}
