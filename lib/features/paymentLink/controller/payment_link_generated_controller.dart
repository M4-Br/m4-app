import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/paymentLink/model/payment_link_response.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class PaymentLinkGeneratedController extends BaseController {
  final Rxn<PaymentLinkResponse> paymentLink = Rxn<PaymentLinkResponse>();

  final _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  final String currentDate;

  PaymentLinkGeneratedController()
      : currentDate = DateFormat("d 'de' MMMM 'de' yyyy | HH:mm", 'pt_BR')
            .format(DateTime.now());

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is PaymentLinkResponse) {
      paymentLink.value = args;
    } else if (args != null && args is Map && args.containsKey('payment')) {
      paymentLink.value = args['payment'];
    }
  }

  String get formattedValue {
    if (paymentLink.value == null) return 'R\$ 0,00';
    return _currencyFormat.format(paymentLink.value!.value);
  }

  Future<void> shareLink() async {
    if (paymentLink.value == null) return;

    if (isLoading.value) return;

    await executeSafe(() async {
      await Share.share(
          'Pague com o Link de Pagamento. É rápido, é fácil, é seguro: ${paymentLink.value!.link}');
    }, message: 'Erro ao compartilhar link');
  }

  void goBack() {
    Get.back();
  }
}
