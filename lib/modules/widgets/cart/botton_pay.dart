import 'package:flutter/material.dart';

import '../../../core/utils/app_size.dart';
import '../../../core/utils/screen_config.dart';

class BottomPayment extends StatelessWidget {
  final Function onTap;
  final String text;
  final String? totalPrice;
  const BottomPayment({
    super.key,
    required this.onTap,
    required this.text,
    this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                ),
              ),
              AppSize.sv_5,
              Text(
                '\$ ${totalPrice ?? 100}',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
              ),
            ],
          ),
          AppSize.sh_20,
          Expanded(
            child: ElevatedButton(
              onPressed: () => onTap(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(
                  SizeConfig.screenWidth * 0.5,
                  SizeConfig.screenHeight * 0.08,
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
