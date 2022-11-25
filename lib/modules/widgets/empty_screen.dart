import 'package:flutter/material.dart';
import '../../core/utils/app_size.dart';
import '../../core/utils/screen_config.dart';

class EmptyScreen extends StatelessWidget {
  final String? text;
  final String image;
  const EmptyScreen({super.key, required this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.9,
            height: SizeConfig.screenHeight * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          AppSize.sv_10,
          Text(
            text!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          AppSize.sv_30,
        ],
      ),
    );
  }
}
