import 'package:flutter/material.dart';

class CommonItem extends StatefulWidget {
  const CommonItem({Key? key, required this.text, required this.icon, required this.onPressed}) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<CommonItem> createState() => _CommonItemState();
}

class _CommonItemState extends State<CommonItem> {
  IconData _icon = Icons.home;
  String _text = 'Home';

  @override
  void initState() {
    super.initState();
    _icon = widget.icon;
    _text = widget.text;
  }

  @override
  void didUpdateWidget(covariant CommonItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _icon = widget.icon;
    _text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,15, 8, 15),
          child: Row(
            children: [
              Icon(_icon),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(_text, textAlign: TextAlign.start, style: const TextStyle(fontSize: 16),),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}