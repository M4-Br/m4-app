import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpansionItemMyAccount extends StatefulWidget {
  ExpansionItemMyAccount({
    Key? key,
    required this.text,
    required this.account,
    required this.icon,
    required this.bank,
    required this.agency
  }) : super(key: key);

  final String text;
  final String account;
  final IconData icon;
  final String bank;
  final String agency;

  @override
  State<ExpansionItemMyAccount> createState() =>
      _ExpansionItemMyAccountState();
}

class _ExpansionItemMyAccountState extends State<ExpansionItemMyAccount> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12)),
          ),
          child: ExpansionTile(
            leading: Icon(
              widget.icon,
              color: Colors.black,
            ),
            title: Text(
              widget.text,
              style: const TextStyle(fontSize: 16),
            ),
            children: [
              Container(
                color: Colors.grey[100],
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 8, 0, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text('account_bank'.tr,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Text(widget.bank, style: const TextStyle(fontSize: 16)),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text('account_agency'.tr,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Text(widget.agency, style: const TextStyle(fontSize: 16)),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text('account_account'.tr,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Text(widget.account, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
