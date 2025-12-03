import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/pix/copyPaste/controller/pix_copy_paste_controller.dart';
import 'package:get/get.dart';

class PixCopyPasteBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixCopyPasteController>(
      () => PixCopyPasteController(Get.find<BalanceRx>()),
    );
  }
}
