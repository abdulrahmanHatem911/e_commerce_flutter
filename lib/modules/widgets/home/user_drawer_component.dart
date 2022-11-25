import 'package:flutter/material.dart';

import '../../../core/utils/app_strings.dart';

class UserDrawerComponent extends StatelessWidget {
  const UserDrawerComponent({super.key});

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
                image: AssetImage(AppImage.drawerUser),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
              ),
            ),
            child: SizedBox(),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
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
