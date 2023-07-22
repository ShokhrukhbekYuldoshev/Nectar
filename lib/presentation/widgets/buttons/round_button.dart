import 'package:flutter/material.dart';
import 'package:nectar/presentation/utils/app_colors.dart';

class RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;

  const RoundButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor = AppColors.primary,
    this.iconColor = Colors.white,
    this.borderColor = AppColors.darkBorderGray,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: backgroundColor,
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
