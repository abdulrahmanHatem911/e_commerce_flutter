import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/screen_config.dart';
import '../../../layout/cart/payment_screen.dart';

class DiscountAlertWidget extends StatelessWidget {
  final int totalPrice;
  const DiscountAlertWidget({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.02,
        horizontal: SizeConfig.screenWidth * 0.04,
      ),
      actionsPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.42,
            height: SizeConfig.screenHeight * 0.22,
            decoration: BoxDecoration(
              //color: Colors.red,
              image: DecorationImage(
                image: AssetImage(AppImage.discount),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            'Congratulations!🎉',
            style: GoogleFonts.ubuntu(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          AppSize.sv_5,
          Text(
            'You got a ${_discount(totalPrice) == 20 ? "Gold" : _discount(totalPrice) == 10 ? "Silver" : "Bronze"} discount ${_discount(totalPrice)}% off',
            style: GoogleFonts.ubuntu(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          AppSize.sv_15,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total price: ',
                style: GoogleFonts.ubuntu(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              AppSize.sh_5,
              Text(
                "\$${totalPrice - (totalPrice * _discount(totalPrice) / 100)}",
                style: GoogleFonts.fjallaOne(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          AppSize.sv_15,
          ElevatedButton(
            onPressed: () {
              LayoutCubit.get(context).getAuthToken().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(price: totalPrice),
                  ),
                );
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: Size(
                SizeConfig.screenWidth * 0.5,
                SizeConfig.screenHeight * 0.06,
              ),
            ),
            child: const Text(
              "Confirmation",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          AppSize.sv_15,
        ],
      ),
    );
  }

  _discount(int totalPrice) {
    if (totalPrice >= 1000) {
      return 20;
    } else if (totalPrice >= 500) {
      return 10;
    } else {
      return 5;
    }
  }
}
