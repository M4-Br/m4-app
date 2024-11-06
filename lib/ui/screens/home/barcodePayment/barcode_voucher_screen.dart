import 'package:app_flutter_miban4/data/model/barcode/barcode_payment_model.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BarcodeVoucherScreen extends StatefulWidget {
  final BarcodeVoucher paymentData;

  const BarcodeVoucherScreen({super.key, required this.paymentData});

  @override
  State<BarcodeVoucherScreen> createState() => _BarcodeVoucherScreenState();
}

class _BarcodeVoucherScreenState extends State<BarcodeVoucherScreen> {
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: 'statement_title'.tr,
        backPage: () =>
            Get.off(() => const HomeViewPage(), transition: Transition.leftToRight),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.paymentData.paymentType.toUpperCase(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text.rich(
                TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(text: '${widget.paymentData.transactionDate}'),
                    ]),
                textAlign: TextAlign.center,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  height: 1,
                  color: Colors.black45,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.paymentData.paymentStatus,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'statement_code'.tr,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.paymentData.id,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'statement_value'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      'R\$${currencyFormat.format(int.parse(widget.paymentData.amount.toString()) / 100)}',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  height: 1,
                  color: Colors.black45,
                ),
              ),
              Text(
                'statement_origin'.tr,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'name'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Flexible(
                      child: Text(
                        widget.paymentData.payer.name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'statement_document'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.paymentData.payer.document,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'statement_institute'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const Text(
                      'Miban4',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  height: 1,
                  color: Colors.black45,
                ),
              ),
              Text(
                'statement_destiny'.tr,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'name'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Flexible(
                      child: Text(
                        widget.paymentData.beneficiary.name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'statement_document'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.paymentData.beneficiary.document,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'barcode_barcode'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Flexible(
                      child: Text(
                        widget.paymentData.barCode,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        overflow: TextOverflow.visible,
                        maxLines: 3,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
