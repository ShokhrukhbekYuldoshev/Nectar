import 'package:flutter/material.dart';
import 'package:nectar/src/presentation/utils/app_colors.dart';

class SearchTextField extends StatelessWidget {
  final VoidCallback? onSubmitted;
  final VoidCallback? onChanged;
  final TextEditingController controller;
  final String hintText;

  const SearchTextField({
    super.key,
    this.onSubmitted,
    this.onChanged,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (_) {
        if (onChanged == null) return;
        onChanged!();
      },
      onSubmitted: (_) {
        if (onSubmitted == null) return;
        onSubmitted!();
      },
      controller: controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: AppColors.grayishLimeGreen,
        filled: true,
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: () {
            if (onSubmitted == null) return;
            onSubmitted!();
          },
          icon: const Icon(
            Icons.search_rounded,
            color: AppColors.text,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
