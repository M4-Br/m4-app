import 'package:app_flutter_miban4/data/model/transaction/ted.dart';
import 'package:app_flutter_miban4/data/model/transaction/transaction.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_contact_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_voucher_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class TransferSuccessPage extends StatefulWidget {
  final Transaction? transaction;
  final Ted? ted;
  final String? document;

  const TransferSuccessPage(
      {super.key, this.transaction, this.ted, this.document});

  @override
  State<TransferSuccessPage> createState() => _TransferSuccessPageState();
}

class _TransferSuccessPageState extends State<TransferSuccessPage> {
  final formattedDate = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    final String cpf = widget.ted?.receiver!.document.toString() ??
        widget.transaction!.receiver!.receiverDocument.toString();

    String formatCPF(String cpf) {
      return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
    }

    final int amount = widget.transaction?.values?.receivableAmount! ?? widget.ted!.amount!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.transfer,
        backPage: () =>
            Get.off(() => const HomeViewPage(), transition: Transition.leftToRight),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              AppLocalizations.of(context)!.transfer_success,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_valueConfirm,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(amount / 100)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_date,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.transaction?.transactionDate.toString() ??
                      widget.ted!.receiver!.name!,
                  style: const TextStyle(
                      fontSize: 16),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_to_confirm,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.transaction?.receiver?.receiverFullName.toString() ??
                      widget.ted!.receiver!.name!,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'CPF:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  formatCPF(cpf),
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_bank,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.transaction?.receiver!.receiverBank! ??
                      widget.ted!.receiver!.bankName!,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_account,
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  'Miban4',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_fees,
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  '0,00',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: TransferVoucherPage(
                          transaction: widget.transaction!,
                          ted: widget.ted,
                          document: widget.document,
                        ),
                        type: PageTransitionType.rightToLeft));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                AppLocalizations.of(context)!.transfer_voucher,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const TransferContactPage(),
                        type: PageTransitionType.rightToLeft));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                AppLocalizations.of(context)!.transfer_new,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
