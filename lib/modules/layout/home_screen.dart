import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/layout_cubit/layout_cubit.dart';
import '../../core/style/app_color.dart';
import '../../core/utils/screen_config.dart';
import '../widgets/build_circular_widget.dart';
import '../widgets/build_flutter_toast.dart';
import '../widgets/home/categories_compnent.dart';
import '../widgets/home/home_banner_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          if (state is LayoutInsertToDatabaseState) {
            showFlutterToast(
              message: 'Added to cart',
              toastColor: Colors.green,
            );
          }
        },
        builder: (context, state) {
          LayoutCubit layoutCubit = LayoutCubit.get(context);
          return SafeArea(
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
                      title: 'Man Clothes',
                      onTap: () {},
                    ),
                    layoutCubit.manProducts.isNotEmpty
                        ? CategoriesComponent(
                            productList: LayoutCubit.get(context).manProducts,
                          )
                        : const BuildCircularWidget(),
                    _buildTitle(
                      title: 'Woman Clothes',
                      onTap: () {},
                    ),
                    layoutCubit.womanProducts.isNotEmpty
                        ? CategoriesComponent(
                            productList: LayoutCubit.get(context).womanProducts,
                          )
                        : const BuildCircularWidget(),
                    _buildTitle(
                      title: 'Jewelery',
                      onTap: () {},
                    ),
                    layoutCubit.jewelery.isNotEmpty
                        ? CategoriesComponent(
                            productList: LayoutCubit.get(context).jewelery,
                          )
                        : const BuildCircularWidget(),
                  ],
                ),
              ),
            ),
          );
        },
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
