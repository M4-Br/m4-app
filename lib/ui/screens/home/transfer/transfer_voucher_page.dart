import 'dart:io';

import 'package:app_flutter_miban4/data/model/transaction/ted.dart';
import 'package:app_flutter_miban4/data/model/transaction/transaction.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class TransferVoucherPage extends StatefulWidget {
  final Transaction? transaction;
  final Ted? ted;
  final String? document;

  const TransferVoucherPage(
      {super.key, this.transaction, this.ted, this.document});

  @override
  State<TransferVoucherPage> createState() => _TransferVoucherPageState();
}

class _TransferVoucherPageState extends State<TransferVoucherPage> {
  @override
  Widget build(BuildContext context) {
    final String cpf =
        widget.transaction?.receiver!.receiverDocument.toString() ??
            widget.ted!.receiver!.document!;
    final String payerCpf =
        widget.transaction?.payer!.payerDocument.toString() ?? widget.document!;

    String formatCPF(String cpf) {
      return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
    }

    final int amount =
        widget.transaction?.values?.receivableAmount! ?? widget.ted!.amount!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'transfer_receipt'.tr,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white24,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () async {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: HomeViewPage(),
                    type: PageTransitionType.leftToRight));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'transfer'.tr,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.transaction?.transactionDate!.toString() ??
                    widget.ted!.transactionDate!,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                color: Colors.black87,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status"),
                Text(
                  'Liquidado',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('transfer_code'.tr),
                  Text(
                    widget.transaction?.transactionCode.toString() ??
                        widget.ted!.transactionId!,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('transfer_valueConfirm'.tr),
                  Text(
                    'R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(amount / 100)}',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('transfer_identifier'.tr),
                  Text(
                    widget.transaction?.transactionCode.toString() ??
                        widget.ted!.transactionId!,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                color: Colors.black87,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'transfer_destiny'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('name'.tr),
                Text(
                  widget.transaction?.receiver!.receiverFullName! ??
                      widget.ted!.receiver!.name!,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('CPF/CNPJ'),
                  Text(
                    formatCPF(cpf),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('transfer_institution'.tr),
                  Text(
                    widget.transaction?.receiver!.receiverBank! ??
                        widget.ted!.receiver!.bankName!,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                color: Colors.black87,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'transfer_origin'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('name'.tr),
                Text(
                  widget.transaction?.payer!.payerFullName! ?? '',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('CPF/CNPJ'),
                  Text(
                    formatCPF(payerCpf),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('transfer_institution'.tr),
                  const Text(
                    'Miban4',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void createAndSharePDF(BuildContext context) async {
  //   final pdf = pw.Document();

  //   final tempDir = await getTemporaryDirectory();
  //   final tempPath = tempDir.path;
  //   final pdfFile = File('$tempPath/transaction_voucher.pdf');
  //   await pdfFile.writeAsBytes(await pdf.save());

  //   Share.shareFiles([pdfFile.path], text: 'Comprovante de Transação');
  // }
}
