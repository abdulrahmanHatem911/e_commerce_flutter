import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../widgets/home/categories_compnent.dart';
import '../../widgets/home/home_banner_component.dart';
import '../../widgets/text_form_filed.dart';
import 'package:flutter/material.dart';

import '../../../core/style/app_color.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/screen_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeBannerComponent(),
                _buildTitle(
                  title: 'Clothes',
                  onTap: () {},
                ),
                AppSize.sv_10,
                CategoriesComponent(
                  productList: LayoutCubit.get(context).clothes,
                ),
                AppSize.sv_10,
                _buildTitle(
                  title: 'Electronics',
                  onTap: () {},
                ),
                CategoriesComponent(
                  productList: LayoutCubit.get(context).electronics,
                ),
                AppSize.sv_10,
                _buildTitle(
                  title: 'Shoes',
                  onTap: () {},
                ),
                CategoriesComponent(
                  productList: LayoutCubit.get(context).shoes,
                ),
                AppSize.sv_10,
                _buildTitle(
                  title: 'Furniture',
                  onTap: () {},
                ),
                CategoriesComponent(
                  productList: LayoutCubit.get(context).furniture,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle({required String title, required Null Function() onTap}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            'View All',
            style: TextStyle(
              color: AppColor.primerColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
