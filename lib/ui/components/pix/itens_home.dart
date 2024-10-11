import 'package:flutter/material.dart';

class PixHomeItens extends StatefulWidget {
  const PixHomeItens(
      {Key? key,
      required this.name,
      required this.description,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  final IconData icon;
  final String name;
  final String description;
  final VoidCallback onPressed;

  @override
  State<PixHomeItens> createState() => _PixHomeItensState();
}

class _PixHomeItensState extends State<PixHomeItens> {
  IconData _icon = Icons.home;

  @override
  void initState() {
    super.initState();
    _icon = widget.icon;
  }

  @override
  void didUpdateWidget(covariant PixHomeItens oldWidget) {
    super.didUpdateWidget(oldWidget);
    _icon = widget.icon;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    _icon,
                    size: 36,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
