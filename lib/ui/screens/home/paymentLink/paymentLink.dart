import 'package:app_flutter_miban4/data/model/payment/payment_link_entity.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/paymentLink/paymentLinkValue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class PaymentLink extends StatefulWidget {
  final PaymentLinkEntity? payment;

  const PaymentLink({Key? key, this.payment}) : super(key: key);

  @override
  State<PaymentLink> createState() => _PaymentLinkState();
}

class _PaymentLinkState extends State<PaymentLink> {
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat(
        'd \'${AppLocalizations.of(context)!.off}\' MMMM \'${AppLocalizations.of(context)!.off}\' yyyy | HH:mm',
        'pt_BR');
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.demand_demand,
        backPage: () => Get.off(() => const PaymentLinkValue(),
            transition: Transition.leftToRight),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.payment_link_generated,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                AppLocalizations.of(context)!
                    .payment_link_receive
                    .toUpperCase(),
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              currencyFormat.format(widget.payment!.value),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              dateFormat.format(DateTime.now()),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                AppLocalizations.of(context)!.payment_link_share,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Share.share('Pague com o Link de Pagamento. É rápido, é fácil, é seguro: ${widget.payment!.link}');
                },
                label: Text(
                  AppLocalizations.of(context)!
                      .payment_link_share_link
                      .toUpperCase(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                icon: const Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
