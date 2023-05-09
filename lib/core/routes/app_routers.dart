import 'package:e_commerce_flutter/modules/layout/setting/edit_profile_screen.dart';
import 'package:flutter/material.dart';

import '../../modules/auth/login_screen.dart';
import '../../modules/auth/signup_screen.dart';
import '../../modules/layout/cart/cart_sreen.dart';
import '../../modules/layout/cart/payment_screen.dart';
import '../../modules/layout/cart/ref_code_screen.dart';
import '../../modules/layout/layout_screen.dart';
import '../../modules/layout/product_details.dart';
import '../../modules/layout/search_screen.dart';
import '../../modules/layout/splash_screen.dart';
import '../../modules/widgets/categories/product_by_category_id.dart';

class Routers {
  static const String INIT_ROUTE = '/';
  static const String SPLASH_SCREEN = '/splash';
  static const String LOGIN = '/login_screen';
  static const String REGISTER = '/register_screen';
  static const String LAYOUT_SCREEN = '/layout_screen';
  static const String CART_SCREEN = '/cart_screen';
  static const String PAYMENT_SCREEN = '/payment_screen';
  static const String PRODUCT_DETAILS = '/product_details';
  static const String GRID_VIEW = '/grid_view';
  static const String SEARCH_SCREEN = '/search_screen';
  static const String REF_CODE_SCREEN = '/ref_code_screen';
  static const String EDIT_PROFILE_SCREEN = '/edit_profile_screen';
}

class RoutersGenerated {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routers.SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routers.LAYOUT_SCREEN:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());
      case Routers.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routers.REGISTER:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routers.CART_SCREEN:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routers.PAYMENT_SCREEN:
        return MaterialPageRoute(
            builder: (_) => PaymentScreen(), settings: settings);
      case Routers.PRODUCT_DETAILS:
        return MaterialPageRoute(
          builder: (_) => const ProductDetails(),
          settings: settings,
        );
      case Routers.GRID_VIEW:
        return MaterialPageRoute(
            builder: (_) => const ProductByCategoryId(), settings: settings);
      case Routers.SEARCH_SCREEN:
        return MaterialPageRoute(
            builder: (_) => SearchScreen(), settings: settings);
      case Routers.REF_CODE_SCREEN:
        return MaterialPageRoute(
            builder: (_) => const RefCodeScreen(), settings: settings);
      case Routers.EDIT_PROFILE_SCREEN:
        return MaterialPageRoute(
            builder: (_) => const EditProfileScreen(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());
    }
  }
}
