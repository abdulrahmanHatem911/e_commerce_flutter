import '../../../controllers/auth_cubit/auth_cubit.dart';
import '../../../controllers/auth_cubit/auth_state.dart';
import '../../../core/routes/app_routers.dart';
import '../../../core/style/app_color.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/screen_config.dart';
import '../../../core/widget/circular_progress_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/style/icon_broken.dart';
import '../../../core/utils/app_size.dart';
import '../../widgets/bottom_app.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSignOutSuccessState) {
            CircularProgressComponent.showSnackBar(
                context: context, message: 'SGIN OUT', color: Colors.green);
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routers.LOGIN,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
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
                              'Paige Turner',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            AppSize.sv_5,
                            Text(
                              'paigeturner@gmail.com',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            AppSize.sv_5,
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primerColor,
                                minimumSize: Size(
                                  SizeConfig.screenWidth * 0.5,
                                  SizeConfig.screenHeight * 0.05,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  letterSpacing: 1.3,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppSize.sv_10,
                  Column(
                    children: [
                      _buildListItem(
                        context,
                        title: 'Dark Mood',
                        leadingIcon: IconBroken.Setting,
                      ),
                      _buildListItem(
                        context,
                        title: 'RTL',
                        leadingIcon: IconBroken.Setting,
                      ),
                      _buildListItem(
                        context,
                        title: 'Pages',
                        leadingIcon: IconBroken.Paper,
                        subtitle: 'ongoing Orders, Recent Orders..',
                      ),
                      _buildListItem(
                        context,
                        title: 'Orders',
                        leadingIcon: IconBroken.Paper_Fail,
                        subtitle: 'ongoing Orders, Recent Orders..',
                        onTapFunction: () {},
                      ),
                      _buildListItem(
                        context,
                        title: 'Your WishList',
                        leadingIcon: IconBroken.Heart,
                        subtitle: 'your save products',
                        onTapFunction: () {},
                      ),
                      _buildListItem(
                        context,
                        title: 'Payment',
                        leadingIcon: IconBroken.Buy,
                        subtitle: 'save cart wallet',
                        onTapFunction: () {},
                      ),
                      _buildListItem(
                        context,
                        title: 'Save address',
                        leadingIcon: IconBroken.Location,
                        subtitle: 'Home Office',
                      ),
                      _buildListItem(
                        context,
                        title: 'Langage',
                        leadingIcon: IconBroken.User,
                        subtitle: 'Select your langage her',
                      ),
                      _buildListItem(
                        context,
                        title: 'Notification',
                        leadingIcon: IconBroken.Notification,
                        subtitle: 'offers Order Tracking message',
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
                    ],
                  ),
                  AppSize.sv_10,
                  BottomComponent(
                    child: Text(
                      'Sign Out',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
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
      ),
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
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(subtitle ?? ''),
        trailing: Icon(tailIcon),
      ),
    );
  }
}
