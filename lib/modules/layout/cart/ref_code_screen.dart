import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../core/network/local/sql_server.dart';
import '../../../core/network/remote/api_constant.dart';
import '../../../core/routes/app_routers.dart';
import '../../../core/style/icon_broken.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/screen_config.dart';

class RefCodeScreen extends StatelessWidget {
  const RefCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () => _buildExitDialog(context),
            icon: const Icon(IconBroken.Logout, color: Colors.black),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'you can get ref code from here',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            AppSize.sv_15,
            Text(
              'The ref code is:',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            AppSize.sv_20,
            Container(
              padding: const EdgeInsets.all(20.0),
              width: SizeConfig.screenWidth * .8,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  ApiConstant.refCode,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 23.0,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Are you sure not completed the pay',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                SqliteServiceDatabase().deleteAllItems('cart').then((value) {
                  BlocProvider.of<LayoutCubit>(context).currentIndex = 0;
                });
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routers.LAYOUT_SCREEN,
                  (route) => false,
                );
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
