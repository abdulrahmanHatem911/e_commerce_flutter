import 'package:e_commerce_flutter/modules/screens/auth/login_screen.dart';
import 'package:e_commerce_flutter/modules/screens/cart/cart_sreen.dart';
import 'package:e_commerce_flutter/modules/screens/layout_screen.dart';
import 'package:e_commerce_flutter/modules/screens/product_details.dart';
import 'package:flutter/material.dart';
import '../../modules/screens/auth/signup_screen.dart';
import '../../modules/screens/cart/payment_screen.dart';
import '../../modules/screens/cart/ref_code_screen.dart';
import '../../modules/screens/cart/visa_screen.dart';
import '../../modules/screens/search_screen.dart';
import '../../modules/screens/splash_screen.dart';
import '../../modules/widgets/categories/product_by_category_id.dart';

class Routers {
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
      default:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());
    }
  }
}
