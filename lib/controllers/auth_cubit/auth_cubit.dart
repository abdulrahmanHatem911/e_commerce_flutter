import 'package:e_commerce_flutter/core/services/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/remote/api_constant.dart';
import '../../core/network/remote/dio_helper.dart';
import '../../core/utils/constent.dart';
import '../../models/auth_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  Future<void> userAuthRegistrationDio({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String userName,
  }) async {
    emit(AuthRegistrationLoadingState());
    await DioHelper.postData(url: ApiConstant.REGISTER, data: {
      "firstName": firstName,
      "lastName": lastName,
      "username": userName,
      "email": email,
      "password": password,
      "address": address,
      "phoneNumber": phone,
    }).then((value) {
      print('Done 🔥');
      CURRENT_USER = AuthModel.fromJson(value.data);
      emit(AuthRegistrationSuccessState(user: value.data['roles'][0]));
    }).catchError((error) {
      print('error: 🚀${error.toString()}');
      emit(AuthRegistrationErrorState(error.toString()));
    });
  }

  Future<void> userLoginDio(
      {required String email, required String password}) async {
    emit(AuthLoginLoadingState());
    await DioHelper.postData(
        url: ApiConstant.LOGIN,
        data: {"email": email, "password": password}).then((value) {
      print('Done 🎉 ${value.data}');
      print('roles  Done 🎉 ${value.data['token']}');
      CacheHelper.saveData(key: 'token', value: '${value.data['token']}');
      CacheHelper.saveData(key: 'name', value: '${value.data['firstName']}');
      CacheHelper.saveData(key: 'email', value: '${value.data['email']}');
      CacheHelper.saveData(key: 'user', value: 'user');
      CURRENT_USER = AuthModel.fromJson(value.data);
      print('The token is ${CacheHelper.getData(key: 'token')}');
      emit(AuthLoginSuccessState(user: 'user'));
    }).catchError((error) {
      print('error: 🚀${error.toString()}');
      emit(AuthLoginErrorState(error.toString()));
    });
  }
}
