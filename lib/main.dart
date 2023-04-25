import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/cart_provider.dart';
import 'core/network/local/sql_server.dart';
import 'core/network/remote/dio_helper.dart';
import 'core/routes/app_routers.dart';
import 'core/services/cache_helper.dart';
import 'core/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await SqliteService().initializeDB();
  await CacheHelper.init();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            onGenerateRoute: RoutersGenerated.onGenerateRoute,
            initialRoute: Routers.SPLASH_SCREEN,
          );
        },
      ),
    );
  }
}
