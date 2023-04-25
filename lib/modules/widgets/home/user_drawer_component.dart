import 'package:e_commerce_flutter/modules/widgets/build_flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/auth_cubit/auth_cubit.dart';
import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../core/routes/app_routers.dart';
import '../../../core/style/app_color.dart';
import '../../../core/style/icon_broken.dart';
import '../../../core/utils/app_strings.dart';

class UserDrawerComponent extends StatelessWidget {
  const UserDrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Drawer(
        semanticLabel: 'Drawer',
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImage.drawerUser),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                      ),
                    ),
                    child: SizedBox(),
                  ),
                  _buildListTile(
                    context: context,
                    title: "Home",
                    icon: IconBroken.Home,
                    index: 2,
                  ),
                  _buildListTile(
                    context: context,
                    title: "Categories",
                    icon: IconBroken.Category,
                    index: 3,
                  ),
                  _buildListTile(
                    context: context,
                    title: "Favorites",
                    icon: IconBroken.Heart,
                    index: 1,
                  ),
                  _buildListTile(
                    context: context,
                    title: "Cart",
                    icon: IconBroken.Bag,
                    index: 0,
                  ),
                  _buildListTile(
                    context: context,
                    title: "Settings",
                    icon: IconBroken.Setting,
                    index: 4,
                  ),
                ],
              ),
            ),
            BlocConsumer<LayoutCubit, LayoutState>(
              listener: (context, state) {
                if (state is UserSignOutSuccessState) {
                  showFlutterToast(
                    message: "Sign Out Successfully",
                    toastColor: Colors.green,
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routers.LOGIN,
                    (route) => false,
                  );
                }
              },
              builder: (context, state) {
                var cubit = LayoutCubit.get(context);
                return InkWell(
                  onTap: () => cubit.userSignOutDio(),
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    color: AppColor.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Log Out",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                color: Colors.white,
                              ),
                        ),
                        const Spacer(),
                        const Icon(
                          IconBroken.Logout,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required int index,
  }) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      onTap: () {
        Navigator.pop(context);
        LayoutCubit.get(context).changeBottomNavBar(index);
      },
    );
  }
}
