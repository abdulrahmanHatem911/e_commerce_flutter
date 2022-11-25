import 'package:flutter/material.dart';

class CircularProgressComponent extends StatelessWidget {
  const CircularProgressComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.grey[400],
        strokeWidth: 2,
      ),
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    required MaterialColor color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}
