import 'package:e_commerce_flutter/core/routes/app_routers.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/screen_config.dart';
import '../../widgets/cart/botton_pay.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              itemBuilder: (context, index) {
                return _builtItemList();
              },
              separatorBuilder: (context, index) => AppSize.sv_10,
              itemCount: 15,
            ),
          ),
          BottomPayment(
            text: 'Checkout',
            onTap: () {
              Navigator.pushNamed(context, Routers.PAYMENT_SCREEN);
            },
          ),
        ],
      ),
    );
  }
}

Widget _builtItemList() {
  return Container(
    height: SizeConfig.screenWidth * 0.34,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
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
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage(
                AppImage.testImage03,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        AppSize.sh_5,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Product Name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSize.sv_10,
              const Text(
                'Product Description',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              AppSize.sv_10,
              const Text(
                '\$ 100',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth * 0.28,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.black),
                    onPressed: null,
                  ),
                  Text(
                    '1',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.black),
                    onPressed: null,
                  ),
                ],
              ),
            ),
            const IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: null,
            ),
          ],
        ),
        //delete button
      ],
    ),
  );
}
// empty cart screen
/*EmptyScreen(
           image: AppStrings.cartImage,
            text: 'No items in your cart',
          ),*/