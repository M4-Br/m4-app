import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_contact_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_value_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_another_bank_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferBankPage extends StatefulWidget {
  final Map<String, dynamic>? userTransfer;
  final int? type;
  final String? document;

  const TransferBankPage(
      {super.key, this.userTransfer, this.type, this.document});

  @override
  State<TransferBankPage> createState() => _TransferBankPageState();
}

class _TransferBankPageState extends State<TransferBankPage> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    String formattedCPF = widget.document!.length <= 11
        ? cpfMaskFormatter.maskText(widget.document!)
        : cnpjMaskFormatter.maskText(widget.document!);

    return Scaffold(
      appBar: AppBarDefault(
        title: 'transfer'.tr,
        backPage: () => Get.off(() => const TransferContactPage(),
            transition: Transition.leftToRight),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 8),
              child: Text(
                widget.type == 1 ? widget.userTransfer!['name'].toString() : "",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Text(
            formattedCPF,
            style: const TextStyle(fontSize: 18),
          ),
          widget.type! == 1 ? _buildMiban4() : _buildOtherBank(),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Visibility(
                visible: _isVisible,
                child: const Center(child: CircularProgressIndicator())),
          ),
        ],
      ),
    );
  }

  _buildMiban4() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () async {
              setState(() {
                _isVisible = true;
              });
              await getBalance().then((balance) {
                Get.to(
                    () => TransferValuePage(
                          balance: balance,
                          userTransfer: widget.userTransfer,
                          from: 0,
                          document: widget.document,
                          type: 0,
                        ),
                    transition: Transition.rightToLeft);
                setState(() {
                  _isVisible = false;
                });
              });
              setState(() {
                _isVisible = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_outlined, size: 40.0),
                  const SizedBox(width: 8.0),
                  Text('transfer_miban'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              Get.to(
                  () => TransferAnotherBankScreen(
                        document: widget.document,
                        type: widget.type,
                        userTransfer: widget.userTransfer,
                      ),
                  transition: Transition.rightToLeft);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_rounded, size: 40.0),
                  const SizedBox(width: 8.0),
                  Text('transfer_other'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildOtherBank() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Get.to(
              () => TransferAnotherBankScreen(
                    document: widget.document,
                    type: widget.type,
                    userTransfer: widget.userTransfer,
                  ),
              transition: Transition.rightToLeft);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                spreadRadius: 1.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.account_balance_rounded, size: 40.0),
              const SizedBox(width: 8.0),
              Text('transfer_other'.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
