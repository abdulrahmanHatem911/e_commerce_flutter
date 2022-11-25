import 'package:e_commerce_flutter/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/app_routers.dart';
import '../../../core/style/icon_broken.dart';

class AdminDrawerComponent extends StatelessWidget {
  const AdminDrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'Drawer',
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.drawerAdmin),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
              ),
            ),
            child: SizedBox(),
          ),
          ListTile(
            title: const Text('add product'),
            leading: const Icon(IconBroken.Plus),
            onTap: () {
              Navigator.of(context).pushNamed(
                Routers.ADD_PRODUCT_SCREEN,
              );
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 3'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
