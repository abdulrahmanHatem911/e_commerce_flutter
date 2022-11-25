import 'package:e_commerce_flutter/core/utils/app_strings.dart';
import 'package:e_commerce_flutter/core/utils/screen_config.dart';
import 'package:e_commerce_flutter/models/category_model.dart';
import 'package:e_commerce_flutter/models/product_model.dart';
import 'package:flutter/material.dart';

class GridViewComponent extends StatelessWidget {
  const GridViewComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CategoryModel;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.01,
          vertical: SizeConfig.screenHeight * 0.01,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1 / 1.5,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: NetworkImage(AppImage.testImage),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
