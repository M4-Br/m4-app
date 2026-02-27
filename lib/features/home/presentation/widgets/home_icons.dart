import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:flutter/material.dart';

class HomeIcons extends StatelessWidget {
  const HomeIcons({
    super.key,
    required this.iconUrl,
    required this.text,
    required this.onPressed,
    this.isLocal = false,
    this.iconData,
  });

  final String iconUrl;
  final String text;
  final VoidCallback onPressed;
  final bool isLocal;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIconContent(),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContent() {
    if (iconData != null) {
      return Icon(
        iconData,
        size: 35,
        color: secondaryColor,
      );
    }

    if (iconUrl.isEmpty) {
      return const Icon(Icons.broken_image, size: 35, color: Colors.grey);
    }

    if (isLocal) {
      return Image.asset(
        iconUrl,
        width: 35,
        height: 35,
        color: secondaryColor,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.error, color: secondaryColor),
      );
    }

    return Image.network(
      iconUrl,
      width: 35,
      height: 35,
      color: secondaryColor,
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.error, color: secondaryColor),
    );
  }
}
