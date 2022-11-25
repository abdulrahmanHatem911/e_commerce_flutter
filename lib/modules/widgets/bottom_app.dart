import 'package:flutter/material.dart';

import '../../core/utils/screen_config.dart';

class BottomComponent extends StatelessWidget {
  final Widget child;
  final Function? onPressed;
  const BottomComponent({
    super.key,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: Size(
          SizeConfig.screenWidth * 0.9,
          SizeConfig.screenHeight * 0.065,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: child,
    );
  }
}
