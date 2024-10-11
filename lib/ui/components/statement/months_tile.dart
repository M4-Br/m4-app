import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';

class MonthsTile extends StatelessWidget {
  const MonthsTile({
    required this.months,
    required this.isSelected,
    required this.onTap,
  });

  final String months;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? secondaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            months,
            style: TextStyle(
              color: isSelected ? Colors.white : secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: isSelected ? 16 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
