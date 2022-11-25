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
          SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.5,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(image),
            ),
          ),
          AppSize.sv_10,
          Text(
            text ?? '',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
