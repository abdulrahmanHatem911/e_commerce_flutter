import 'package:e_commerce_flutter/modules/widgets/cart/widgets/discount_alert.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_size.dart';
import '../../../core/utils/screen_config.dart';
import '../build_flutter_toast.dart';

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({super.key, required this.title, required this.value});

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                ),
                AppSize.sv_5,
                Text(
                  r'$ ' + value.toString(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                ),
              ],
            ),
            AppSize.sh_20,
            ElevatedButton(
              onPressed: () {
                // var totalPrice = int.parse(value);
                // LayoutCubit.get(context).getAuthToken().then((value) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => PaymentScreen(price: totalPrice),
                //     ),
                //   );
                // }
                // );
                if (int.parse(value) <= 0) {
                  showFlutterToast(
                    message: 'Please add items to your cart',
                    toastColor: Colors.red,
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        DiscountAlertWidget(totalPrice: int.parse(value)),
                  );
                }
              },
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
              child: const Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
