import 'package:flutter/material.dart';

import '../../core/utils/app_size.dart';
import '../../core/utils/screen_config.dart';
import '../../models/product_model.dart';

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
                    image: NetworkImage(args.imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            AppSize.sv_10,
            Text(
              args.name,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            AppSize.sv_10,
            Text(
              args.description,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            AppSize.sv_10,
            Text(
              '\$${args.price}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
