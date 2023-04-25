import 'package:flutter/material.dart';

class BuildCircularWidget extends StatelessWidget {
  const BuildCircularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
        strokeWidth: 2.0,
      ),
    );
  }
}
