import 'package:e_commerce_flutter/controllers/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_flutter/core/utils/constent.dart';
import 'package:e_commerce_flutter/modules/layout/setting/add_category_screen.dart';
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
import 'add_product_screen.dart';

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
                            CURRENT_USER?.firstName ?? '',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            CURRENT_USER?.email ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildListItem(
                  context,
                  title: 'Add Product',
                  subtitle: 'Add Product, Edit Product, Delete Product',
                  leadingIcon: IconBroken.Plus,
                  onTapFunction: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddProductScreen(),
                      ),
                    );
                  },
                ),
                _buildListItem(
                  context,
                  title: 'Add Category',
                  subtitle: 'Add Category, Edit Category, Delete Category',
                  leadingIcon: IconBroken.Plus,
                  onTapFunction: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddCategoryScreen(),
                      ),
                    );
                  },
                ),
                _buildListItem(
                  context,
                  title: 'Notification',
                  leadingIcon: IconBroken.Setting,
                  subtitle: 'Dark Mood RTL, Notification ',
                ),
                _buildListItem(
                  context,
                  title: 'Profile Setting',
                  leadingIcon: IconBroken.User1,
                  subtitle: 'Full Name',
                ),
                const Spacer(),
                BottomComponent(
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
