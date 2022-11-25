import 'package:e_commerce_flutter/core/utils/app_size.dart';
import 'package:e_commerce_flutter/core/utils/screen_config.dart';
import 'package:e_commerce_flutter/models/product_model.dart';
import 'package:e_commerce_flutter/modules/widgets/bottom_app.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'product_image_${args.id}',
              child: Container(
                height: SizeConfig.screenHeight * 0.35,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${args.imageUrl}"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            AppSize.sv_10,
            Text(
              '${args.name}',
              style: Theme.of(context).textTheme.headline2,
            ),
            AppSize.sv_10,
            Text(
              '${args.description}',
              style: Theme.of(context).textTheme.headline1,
            ),
            AppSize.sv_10,
            Text(
              '\$${args.price}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  '1',
                  style: Theme.of(context).textTheme.headline6,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Spacer(),
            BottomComponent(
              onPressed: () {},
              child: Text(
                'Add to cart',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
