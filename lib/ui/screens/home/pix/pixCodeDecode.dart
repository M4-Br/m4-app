import 'package:app_flutter_miban4/data/api/pix/pixTransfer.dart';
import 'package:app_flutter_miban4/data/model/qrCode/decodeQRCode.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixAddValue.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixTransactionSuccess.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PixCodeDecode extends StatefulWidget {
  late Balance? balance;
  late DecodeQRCode? qrCode;
  late int? page;

  PixCodeDecode({Key? key, this.balance, this.qrCode, this.page})
      : super(key: key);

  @override
  State<PixCodeDecode> createState() => _PixCodeDecodeState();
}

class _PixCodeDecodeState extends State<PixCodeDecode> {
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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: 'PIX',
        backPage: () => widget.page == 1
            ? Get.off(() => PixAddValue(), transition: Transition.leftToRight)
            : Get.off(() => HomeViewPage(), transition: Transition.leftToRight),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  //What will show
                  widget.page == 1
                      ? AppLocalizations.of(context)!.pix_valueTo
                      : AppLocalizations.of(context)!.pix_youReceived,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'R\$ ',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    NumberFormat.currency(locale: 'pt_BR', symbol: '')
                        .format((int.parse(widget.qrCode!.finalAmount) / 100)),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 42,
                        color: secondaryColor),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  widget.qrCode!.title.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  widget.qrCode!.description.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.pix_day,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.black,
                      size: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.pix_to,
                      style: const TextStyle(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black),
                      maxLines: 2,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    Flexible(
                      child: Text(
                        widget.qrCode!.payee.name.toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black),
                        maxLines: 2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'CPF/CNPJ:',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      formatCPF(widget.qrCode!.payee.document.toString()),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.transfer_institution,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      widget.qrCode!.payee.bankName.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.pix_city,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      widget.qrCode!.city,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.transfer_debtor,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      widget.qrCode!.payer.name,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'CPF/CNPJ:',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      '***${formatCPF(widget.qrCode!.payer.document).substring(3, 12)}**',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.pix_due,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(
                        DateTime.parse(widget.qrCode!.dueDate),
                      ),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.pix_originalAmount,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      NumberFormat.currency(locale: 'pt_BR', symbol: '').format(
                          (int.parse(widget.qrCode!.finalAmount) / 100)),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: int.parse(widget.balance!.balanceCents) <
                        int.parse(widget.qrCode!.finalAmount)
                    ? Text(
                        "${AppLocalizations.of(context)!.balance_insufficient} R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format((int.parse(widget.balance!.balanceCents) / 100))}",
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      )
                    : Text(
                        "${AppLocalizations.of(context)!.balance_available} R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format((int.parse(widget.balance!.balanceCents) / 100))}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.page == 1
                              ? Get.to(() => PixAddValue(),
                                  transition: Transition.leftToRight)
                              : Get.off(() => HomeViewPage(),
                                  transition: Transition.leftToRight);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.cancel.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog.adaptive(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
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
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Confirmar'),
                                    onPressed: () async {
                                      Get.back();
                                      _doPayment();
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
                          ),
                          alignment: Alignment.center,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.confirm.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _doPayment() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String amount = widget.qrCode!.finalAmount.toString();
        String password = _controller.text;
        String idText = '';
        String description = widget.qrCode!.description.toString();
        String endToEnd = widget.qrCode!.idEndToEnd.toString();
        String bankAccountNumber =
            widget.qrCode!.payee.bankAccountNumber.toString();
        String bankAccountType =
            widget.qrCode!.payee.bankAccountType.toString();
        String bankBranch = widget.qrCode!.payee.bankBranchNumber.toString();
        String beneficiaryType =
            widget.qrCode!.payee.beneficiaryType.toString();
        String document = widget.qrCode!.payee.document.toString();
        String ispb = widget.qrCode!.payee.ispb.toString();
        String name = widget.qrCode!.payee.name.toString();
        String key = widget.qrCode!.payee.key.toString();
        int transferType = widget.qrCode!.codeType.toInt();
        sendPixTransfer(
                amount,
                description,
                endToEnd,
                password,
                idText,
                bankAccountNumber,
                bankAccountType,
                bankBranch,
                beneficiaryType,
                document,
                ispb,
                name,
                key,
                transferType)
            .then((transfer) {
          if (transfer['success'] == true) {
            Get.off(() => PixTransactionSuccess(transfer: transfer),
                transition: Transition.rightToLeft);
          }
        });
        return AlertDialog.adaptive(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            AppLocalizations.of(context)!.wait,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          content: const CircularProgressIndicator(
            color: secondaryColor,
          ),
        );
      },
    );
  }
}
