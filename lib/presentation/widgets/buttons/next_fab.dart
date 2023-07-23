import 'package:flutter/material.dart';
import 'package:nectar/presentation/utils/app_colors.dart';

class NextFab extends StatelessWidget {
  final VoidCallback onPressed;

  const NextFab({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      shape: const CircleBorder(),
      onPressed: onPressed,
      child: const Icon(
        Icons.navigate_next,
        color: Colors.white,
        size: 32,
      ),
    );
  }
}
