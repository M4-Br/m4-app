import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_user_response.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TransferBankController extends BaseController {
  TransferUserResponse? userDestiny;

  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
  final cnpjMask = MaskTextInputFormatter(mask: '##.###.###/####-##');

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    final args = Get.arguments;

    if (args != null && args is TransferUserResponse) {
      userDestiny = args;
    }
  }

  String get beneficiaryName {
    return userDestiny?.name ?? '';
  }

  String get formattedDocument {
    final doc = userDestiny?.document ?? '';

    if (doc.isEmpty) return '';
    if (doc.length <= 11) {
      return cpfMask.maskText(doc);
    } else {
      return cnpjMask.maskText(doc);
    }
  }

  Future<void> goToTransferValue() async {
    if (userDestiny == null) {
      ShowToaster.toasterInfo(message: 'Beneficiário inválido', isError: true);
      return;
    }

    await executeSafe(() async {
      Get.toNamed(AppRoutes.transferValueAndConfirm, arguments: userDestiny);
    });
  }

  void goToOtherBank() {
    ShowToaster.toasterInfo(message: 'Indisponível no momento');
  }
}
