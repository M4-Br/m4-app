import 'package:app_flutter_miban4/data/api/barcode/barcode_payment.dart';
import 'package:app_flutter_miban4/data/model/barcode/barcode_payment_model.dart';
import 'package:app_flutter_miban4/data/model/barcode/decodeBarcode.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/barcodePayment/barcode_scan.dart';
import 'package:app_flutter_miban4/ui/screens/home/barcodePayment/barcode_voucher_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BarcodeConfirmPayment extends StatefulWidget {
  final PaymentData paymentData;
  final Balance balance;

  const BarcodeConfirmPayment({
    super.key,
    required this.paymentData,
    required this.balance,
  });

  @override
  State<BarcodeConfirmPayment> createState() => _BarcodeConfirmPaymentState();
}

class _BarcodeConfirmPaymentState extends State<BarcodeConfirmPayment> {
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var _obscureText = false.obs;
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(today);

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.pay,
        backPage: () => Get.off(() => const BarcodeScanScreen(),
            transition: Transition.leftToRight),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              AppLocalizations.of(context)!.payment_total,
              style: const TextStyle(fontSize: 16),
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
                    .format(int.parse(widget.paymentData.amount) / 100),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: secondaryColor),
              ),
            ],
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                  '${AppLocalizations.of(context)!.balance_available}: R\$ ${currencyFormat.format(double.parse(widget.balance.balanceCents) / 100)}')),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.payment_realized,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                      color: secondaryColor,
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
                Text(
                  AppLocalizations.of(context)!.payment_expired,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(
                    DateTime.parse(widget.paymentData.dueDate),
                  ),
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
                  AppLocalizations.of(context)!.payment_receiver,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.paymentData.assignor.length > 10
                      ? '${widget.paymentData.assignor.substring(0, 10)}...'
                      : widget.paymentData.assignor,
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
                  AppLocalizations.of(context)!.payment_barcode,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.paymentData.digitableLine.length > 10
                      ? '${widget.paymentData.digitableLine.substring(0, 10)}...'
                      : widget.paymentData.digitableLine,
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
                  AppLocalizations.of(context)!.payment_discount,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  NumberFormat.currency(locale: 'pt_BR', symbol: '').format(
                      double.parse(widget.paymentData.details.discount ?? '0')),
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
                  AppLocalizations.of(context)!.payment_fees,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  NumberFormat.currency(locale: 'pt_BR', symbol: '').format(
                      double.parse(widget.paymentData.details.interest ?? '0')),
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
                  AppLocalizations.of(context)!.payment_fine,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  NumberFormat.currency(locale: 'pt_BR', symbol: '').format(
                      double.parse(widget.paymentData.details.fine ?? '0')),
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Obx(
              () => isLoading.value == false
                  ? SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _payment(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.pay_barcode,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: secondaryColor,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _payment() async {
    TextEditingController passwordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.password_insert,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    obscureText: !_obscureText.value,
                    decoration: InputDecoration(
                      floatingLabelStyle:
                          const TextStyle(color: secondaryColor),
                      counterText: '',
                      suffixIcon: Obx(
                        () => IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText.value = !_obscureText.value;
                            });
                          },
                          icon: Icon(
                            _obscureText.value == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: secondaryColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            Get.back();
                            await _processPayment(passwordController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.confirm.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.cancel.toUpperCase(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _processPayment(String password) async {
    isLoading(true);

    int amount = int.parse(widget.paymentData.amount);
    String barcode = widget.paymentData.barCode;
    String assignor = widget.paymentData.assignor;

    DateTime today = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(today);

    try {
      BarcodeVoucher payment =
          await payBarcode(context, amount, password, barcode, formattedDate, assignor);

      if (payment.success == true) {
        Get.to(() => BarcodeVoucherScreen(paymentData: payment));
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
