import 'package:e_commerce_flutter/core/utils/app_strings.dart';
import 'package:e_commerce_flutter/modules/widgets/bottom_app.dart';
import 'package:e_commerce_flutter/modules/widgets/text_form_filed.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_size.dart';
import '../../core/utils/screen_config.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Add Product'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8.0,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: AssetImage(AppImage.addProduct),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  AppSize.sv_10,
                  TextFormFiledComponent(
                    keyboardType: TextInputType.text,
                    hintText: 'Product Name',
                    prefixIcon: Icons.title,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product Name';
                      }
                      return null;
                    },
                  ),
                  AppSize.sv_10,
                  const TextFormFiledComponent(
                    keyboardType: TextInputType.text,
                    hintText: 'Product Name',
                    prefixIcon: Icons.title,
                  ),
                  AppSize.sv_10,
                  const TextFormFiledComponent(
                    keyboardType: TextInputType.text,
                    hintText: 'Product Name',
                    prefixIcon: Icons.title,
                  ),
                  AppSize.sv_10,
                  const TextFormFiledComponent(
                    keyboardType: TextInputType.text,
                    hintText: 'Product Name',
                    prefixIcon: Icons.title,
                  ),
                  AppSize.sv_10,
                  BottomComponent(
                    child: Text(
                      'Add Product',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    onPressed: () {},
                  ),
                  AppSize.sv_20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
