import 'package:flutter/material.dart';

class ExpansionItem extends StatefulWidget {
  ExpansionItem({
    Key? key,
    required this.icon,
    required this.fieldName,
    required this.firstFieldName,
    required this.firstField,
    required this.secondFieldName,
    required this.secondField,
  }) : super(key: key);

  final String fieldName;
  final IconData icon;
  final String firstFieldName;
  final String firstField;
  final String secondFieldName;
  final String secondField;

  @override
  State<ExpansionItem> createState() => _ExpansionItemState();
}

class _ExpansionItemState extends State<ExpansionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: ExpansionTile(
        leading: Icon(
          widget.icon,
          color: Colors.black,
        ),
        title: Text(
          widget.fieldName,
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
                    child: Text(
                      widget.firstFieldName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    widget.firstField,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      widget.secondFieldName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    widget.secondField,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
