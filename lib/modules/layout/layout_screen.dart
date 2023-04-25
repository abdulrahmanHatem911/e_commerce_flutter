
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../controllers/layout_cubit/layout_cubit.dart';
import '../../core/routes/app_routers.dart';
import '../../core/services/cache_helper.dart';
import '../widgets/home/user_drawer_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/style/app_color.dart';
import '../../core/style/icon_broken.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                //search
              ],
            ),
            drawer: const UserDrawerComponent(),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: CurvedNavigationBar(
                index: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                color: Colors.white,
                backgroundColor: Colors.grey.shade200,
                buttonBackgroundColor: AppColor.blue,
                height: 50.0,
                items: const [
                  Icon(
                    IconBroken.Bag,
                    size: 25,
                  ),
                  Icon(
                    IconBroken.Heart,
                    size: 25,
                  ),
                  Icon(
                    IconBroken.Home,
                    size: 25,
                  ),
                  Icon(
                    IconBroken.Category,
                    size: 25,
                  ),
                  Icon(
                    IconBroken.Profile,
                    size: 25,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
