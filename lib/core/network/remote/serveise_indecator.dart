// Create a new instance of GetIt
import 'package:get_it/get_it.dart';

import '../../../controllers/auth_cubit/auth_cubit.dart';
import '../../../controllers/layout_cubit/layout_cubit.dart';
import 'dio_helper.dart';

// This is our global ServiceLocator
class ServiceLocator {
  static final GetIt instance = GetIt.instance;

  static Future<void> init() async {
    //helper
    instance.registerLazySingleton(() => DioHelper());
    instance.registerLazySingleton(() => HttpHelper());

    //cubit
    instance.registerFactory<AuthCubit>(() => AuthCubit(dioHelper: instance()));
    instance
        .registerFactory<LayoutCubit>(() => LayoutCubit(dioHelper: instance()));
  }
}
