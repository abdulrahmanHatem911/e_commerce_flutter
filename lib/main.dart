import 'dart:io';
import 'package:e_commerce_flutter/controllers/cart_provider.dart';
import 'package:e_commerce_flutter/core/network/local/sql_server.dart';
import 'package:e_commerce_flutter/core/network/remote/dio_helper.dart';
import 'package:e_commerce_flutter/core/services/cache_helper.dart';
import 'package:e_commerce_flutter/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
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
