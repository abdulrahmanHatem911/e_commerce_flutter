import 'package:e_commerce_flutter/controllers/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_flutter/controllers/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_flutter/modules/auth/login_screen.dart';
import 'package:e_commerce_flutter/modules/layout/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'controllers/cart_provider.dart';
import 'core/network/local/sql_server.dart';
import 'core/network/remote/dio_helper.dart';
import 'core/network/remote/serveise_indecator.dart';
import 'core/routes/app_routers.dart';
import 'core/services/cache_helper.dart';
import 'core/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await ServiceLocator.init();
  await SqliteServiceDatabase().initializeDB();
  await CacheHelper.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp(startWidget: checkUser()));
}

checkUser() {
  print('The user token is ${CacheHelper.getData(key: 'token')}');
  var user = CacheHelper.getData(key: 'user') ?? '';
  if (user == 'user') {
    return const LayoutScreen();
  } else if (user == 'admin') {
    return const LayoutScreen();
  } else {
    return LoginScreen();
  }
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({
    super.key,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit()
            ..getAllProduct()
            ..getAllCategory()
            ..getAllFavorites(),
        ),
        BlocProvider(create: (context) => AuthCubit()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            onGenerateRoute: RoutersGenerated.onGenerateRoute,
            initialRoute: Routers.INIT_ROUTE,
            home: startWidget,
          );
        },
      ),
    );
  }
}
