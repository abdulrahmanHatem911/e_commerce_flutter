import 'package:e_commerce_flutter/controllers/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_flutter/core/routes/app_routers.dart';
import 'package:e_commerce_flutter/core/services/cache_helper.dart';
import 'package:e_commerce_flutter/modules/widgets/home/admin_drawer_component.dart';
import 'package:e_commerce_flutter/modules/widgets/home/user_drawer_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/style/app_color.dart';
import '../../core/style/icon_broken.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var admin = CacheHelper.getData(key: 'admin');
    return BlocProvider(
      create: (context) => LayoutCubit()
        ..getProductDio()
        ..getCategoryDio()
        ..getFromDatabase(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.white,
              elevation: 0,
              title: Text(
                'Home',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    IconBroken.Search,
                    color: AppColor.black,
                    size: 20,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, Routers.SEARCH_SCREEN),
                ),
                IconButton(
                  icon: Icon(
                    IconBroken.Bag_2,
                    color: AppColor.black,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routers.CART_SCREEN);
                  },
                ),
                //search
              ],
            ),
            drawer: admin != null && admin != ''
                ? const AdminDrawerComponent()
                : const UserDrawerComponent(),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Category),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Scan),
                  label: 'Payment',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Heart),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Profile),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
