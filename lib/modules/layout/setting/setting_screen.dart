import 'package:e_commerce_flutter/controllers/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_flutter/core/services/cache_helper.dart';
import 'package:e_commerce_flutter/modules/layout/setting/add_category_screen.dart';
import 'package:e_commerce_flutter/modules/layout/setting/products/show_all_products.dart';
import 'package:e_commerce_flutter/modules/widgets/build_circular_widget.dart';
import 'package:e_commerce_flutter/modules/widgets/build_flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_routers.dart';
import '../../../core/style/app_color.dart';
import '../../../core/style/icon_broken.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/screen_config.dart';
import '../../widgets/bottom_app.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is UserSignOutSuccessState) {
          showFlutterToast(
              message: "Sign out successfully 🥳", toastColor: Colors.green);
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routers.LOGIN,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.15,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.2,
                        height: SizeConfig.screenHeight * 0.2,
                        decoration: const BoxDecoration(
                          color: Colors.white10,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(AppImage.testImage01)),
                        ),
                      ),
                      AppSize.sh_10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            CacheHelper.getData(key: 'name') ?? '',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          AppSize.sv_5,
                          Text(
                            CacheHelper.getData(key: 'email') ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildListItem(
                  context,
                  title: 'Products',
                  subtitle: 'show all products,and make some action',
                  leadingIcon: IconBroken.Plus,
                  onTapFunction: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ShowAllProductsScreen(),
                      ),
                    );
                  },
                ),
                _buildListItem(
                  context,
                  title: 'Add Category',
                  subtitle: 'Add Category to your store',
                  leadingIcon: IconBroken.Plus,
                  onTapFunction: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddCategoryScreen(),
                      ),
                    );
                  },
                ),
                const Spacer(),
                state is UserSignOutLoadingState
                    ? const BuildCircularWidget()
                    : BottomComponent(
                        child: Text(
                          'Sign Out',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 20.0),
                        ),
                        onPressed: () {
                          cubit.userSignOutDio();
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required String title,
    required IconData leadingIcon,
    IconData? tailIcon,
    String? subtitle,
    Function()? onTapFunction,
  }) {
    return GestureDetector(
      onTap: onTapFunction,
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: AppColor.primerColor,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(subtitle ?? ''),
        trailing: Icon(tailIcon),
      ),
    );
  }
}
