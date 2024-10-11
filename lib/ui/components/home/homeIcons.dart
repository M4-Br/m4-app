import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';

class HomeIcons extends StatelessWidget {
  const HomeIcons({
    Key? key,
    required this.iconUrl,
    required this.text,
    required this.onPressed,
    this.isLocal = false,
  }) : super(key: key);

  final String iconUrl;
  final String text;
  final VoidCallback onPressed;
  final bool isLocal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.black12),
            right: BorderSide(color: Colors.black12),
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLocal
                ? Image.asset(
                    iconUrl,
                    width: 35,
                    height: 35,
                    color: secondaryColor,
                  )
                : Image.network(
                    iconUrl,
                    width: 35,
                    height: 35,
                    color: secondaryColor,
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
