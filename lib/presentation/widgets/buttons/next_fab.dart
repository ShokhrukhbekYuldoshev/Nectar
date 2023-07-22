import 'package:flutter/material.dart';

class NextFab extends StatelessWidget {
  final VoidCallback onPressed;

  const NextFab({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(
        Icons.navigate_next,
        color: Colors.white,
        size: 32,
      ),
    );
  }
}
