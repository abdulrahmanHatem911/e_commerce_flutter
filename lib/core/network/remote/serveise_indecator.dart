// Create a new instance of GetIt
import 'package:get_it/get_it.dart';

import 'dio_helper.dart';

// This is our global ServiceLocator
class ServiceLocator {
  static final GetIt instance = GetIt.instance;

  static Future<void> init() async {
    instance.registerSingleton<DioHelper>(DioHelper());
    instance.registerSingleton<HttpHelper>(HttpHelper());
  }
}
