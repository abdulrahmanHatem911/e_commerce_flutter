import 'dart:io';
import 'package:e_commerce_flutter/core/network/remote/dio_helper.dart';
import 'package:e_commerce_flutter/core/services/cache_helper.dart';
import 'package:e_commerce_flutter/core/style/theme.dart';
import 'package:flutter/material.dart';
import 'core/routes/app_routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      onGenerateRoute: RoutersGenerated.onGenerateRoute,
      initialRoute: Routers.SPLASH_SCREEN,
    );
  }
}
