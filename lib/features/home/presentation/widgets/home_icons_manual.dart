import 'package:flutter/material.dart';

class HomeIconsManual extends StatefulWidget {
  const HomeIconsManual({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onPressed,
  });

  final IconData iconPath;
  final String text;
  final VoidCallback onPressed;

  @override
  State<HomeIconsManual> createState() => _HomeIconsManualState();
}

class _HomeIconsManualState extends State<HomeIconsManual> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      child: InkWell(
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.iconPath,
                size: 35,
                color: Colors.deepOrange,
              ),
              const SizedBox(height: 10),
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
