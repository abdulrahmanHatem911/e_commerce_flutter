import 'package:e_commerce_flutter/core/network/remote/api_constant.dart';
import 'package:e_commerce_flutter/core/network/remote/dio_helper.dart';
import 'package:e_commerce_flutter/core/services/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/registration_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  RegistrationModel registerModel = RegistrationModel();
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
      registerModel = RegistrationModel.fromJson(value.data);
      emit(AuthRegistrationSuccessState(user: value.data['roles'][0]));
    }).catchError((error) {
      print('error: 🚀${error.toString()}');
      emit(AuthRegistrationErrorState(error.toString()));
    });
  }

  Future<void> userLoginDio({
    required String email,
    required String password,
  }) async {
    emit(AuthLoginLoadingState());
    await DioHelper.postData(url: ApiConstant.LOGIN, data: {
      "email": email,
      "password": password,
    }).then((value) {
      print('Done 🔥');
      registerModel = RegistrationModel.fromJson(value.data);
      if (registerModel.roles.length > 1) {
        CacheHelper.saveData(
          key: 'admin',
          value: registerModel.roles[1],
        );
        CacheHelper.saveData(
          key: 'token',
          value: registerModel.token,
        );
      }
      print('the roles is: ${registerModel.roles}');
      emit(
        AuthLoginSuccessState(user: value.data['roles'][0]),
      );
    }).catchError((error) {
      print('error: 🚀${error.toString()}');
      emit(AuthLoginErrorState(error.toString()));
    });
  }

  //sign out
  Future<void> userSignOutDio() async {
    await CacheHelper.saveData(
      key: 'user',
      value: '',
    ).then((value) {
      CacheHelper.saveData(
        key: 'admin',
        value: '',
      ).then((value) {
        emit(AuthSignOutSuccessState());
      });
    });
  }
}
