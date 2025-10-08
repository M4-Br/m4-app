import 'package:app_flutter_miban4/data/api/transfer/transferSend.dart';
import 'package:app_flutter_miban4/data/model/qrCode/internQRCode.dart';
import 'package:app_flutter_miban4/data/model/transaction/transaction.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_success_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QRCodeConfirmPayment extends StatefulWidget {
  late int? transfer;
  late InternQRCode? qrCode;

  QRCodeConfirmPayment({super.key, this.transfer, this.qrCode});

  @override
  State<QRCodeConfirmPayment> createState() => _QRCodeConfirmPaymentState();
}

class _QRCodeConfirmPaymentState extends State<QRCodeConfirmPayment> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);

    String formatCPF(cpf) {
      return cpf.substring(0, 3) +
          '.' +
          cpf.substring(3, 6) +
          '.' +
          cpf.substring(6, 9) +
          '-' +
          cpf.substring(9);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: 'transfer'.tr,
        backPage: () => Get.off(() => const HomeViewPage(),
            transition: Transition.leftToRight),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Você deseja fazer uma \n transferência no valor de:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'R\$ ',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Text(
                NumberFormat.currency(locale: 'pt_BR', symbol: '')
                    .format(widget.transfer! / 100),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.deepOrange),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'No dia',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                      color: Colors.deepOrange,
                      decoration: TextDecoration.underline,
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
                const Text(
                  'Para:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.qrCode!.username.toString(),
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
                  formatCPF(widget.qrCode!.document.toString()),
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Banco:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Miban4',
                  style: TextStyle(fontSize: 16),
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
                  'Conta:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.qrCode!.accountNumber.toString(),
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Taxa',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '0,00',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog.adaptive(
                        title: const Text('Digite a senha'),
                        content: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          obscureText: true,
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Confirmar'),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  int amount = widget.transfer!;
                                  String password = _controller.text;
                                  String username =
                                      widget.qrCode!.username.toString();
                                  String document =
                                      widget.qrCode!.document.toString();
                                  transactionSend(context, amount, password,
                                          username, document)
                                      .then((Transaction? result) {
                                    if (result!.success == true) {
                                      Get.off(
                                          () => TransferSuccessPage(
                                                transaction: result,
                                              ),
                                          transition: Transition.rightToLeft);
                                    }
                                  });
                                  return const AlertDialog.adaptive(
                                    title: Text(
                                        'Aguarde enquanto concluímos \n a sua tranferência.'),
                                    content: CircularProgressIndicator(),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  alignment: Alignment.center,
                ),
                child: const Text('CONFIRMAR'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
