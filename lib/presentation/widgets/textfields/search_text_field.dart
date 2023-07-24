import 'package:flutter/material.dart';
import 'package:nectar/presentation/utils/app_colors.dart';

class SearchTextField extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController controller;
  final String hintText;

  const SearchTextField({
    super.key,
    required this.onPressed,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (_) {
        if (controller.text.isNotEmpty) {
          onPressed();
        }
      },
      controller: controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: AppColors.grayishLimeGreen,
        filled: true,
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onPressed();
            }
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
