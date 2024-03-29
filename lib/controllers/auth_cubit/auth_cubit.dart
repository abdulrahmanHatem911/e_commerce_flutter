import 'package:e_commerce_flutter/core/services/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/remote/api_constant.dart';
import '../../core/network/remote/dio_helper.dart';
import '../../core/utils/constent.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final DioHelper dioHelper;
  AuthCubit({required this.dioHelper}) : super(AuthInitial());
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
    await dioHelper.postData(url: ApiConstant.REGISTER, data: {
      "firstName": firstName,
      "lastName": lastName,
      "username": userName,
      "email": email,
      "password": password,
      "address": address,
      "phoneNumber": phone,
    }).then((value) async {
      await assignRole(email, password);
      emit(AuthRegistrationSuccessState(user: value.data['roles'][0]));
    }).catchError((error) {
      if (error.toString().contains('400')) {
        emit(AuthRegistrationErrorState('Email is already in use'));
      } else if (error.toString().contains('500')) {
        emit(AuthRegistrationErrorState('Email is already in use'));
      } else {
        emit(AuthRegistrationErrorState(error.toString()));
      }
    });
  }

  Future<void> assignRole(String email, String userPassword) async {
    dioHelper
        .postData(
      url: ApiConstant.ASSIGN_ROLE,
      data: {
        "email": email,
        "roleName": "ADMIN",
      },
      token: ADMIN_TOKEN,
    )
        .then((value) async {
      userLoginDio(email: email, password: userPassword);
    }).catchError((error) {
      emit(AuthAssignRoleErrorState(error.toString()));
    });
  }

  void userLoginDio({required String email, required String password}) {
    emit(AuthLoginLoadingState());
    dioHelper.postData(url: ApiConstant.LOGIN, data: {
      "email": email,
      "password": password,
    }).then((value) async {
      await CacheHelper.saveData(key: 'token', value: '${value.data['token']}');
      await CacheHelper.saveData(key: 'email', value: '${value.data['email']}');
      await CacheHelper.saveData(key: 'user', value: 'user');
      emit(AuthLoginSuccessState(user: 'user'));
    }).catchError((error) {
      if (error.toString().contains('400')) {
        emit(AuthLoginErrorState('Email or password is incorrect'));
      } else if (error.toString().contains('500')) {
        emit(AuthLoginErrorState('Email or password is incorrect'));
      } else {
        emit(AuthLoginErrorState(error.toString()));
      }
    });
  }
}
