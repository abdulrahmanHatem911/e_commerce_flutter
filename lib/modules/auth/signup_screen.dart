import 'package:e_commerce_flutter/modules/widgets/build_flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/auth_cubit/auth_cubit.dart';
import '../../controllers/auth_cubit/auth_state.dart';
import '../../core/routes/app_routers.dart';
import '../../core/style/app_color.dart';
import '../../core/utils/app_size.dart';
import '../../core/widget/circular_progress_component.dart';
import '../widgets/bottom_app.dart';
import '../widgets/build_circular_widget.dart';
import '../widgets/text_form_filed.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //form key
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegistrationSuccessState) {
            showFlutterToast(
                message: 'Registration Success 🎉', toastColor: Colors.green);
          }
          if (state is AuthAssignRoleErrorState) {
            showFlutterToast(
                message: 'Assign Role Error 🙂', toastColor: Colors.red);
          }
          if (state is AuthLoginSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routers.LAYOUT_SCREEN,
              (route) => false,
            );
          }
          if (state is AuthRegistrationErrorState) {
            CircularProgressComponent.showSnackBar(
              context: context,
              message: state.error,
              color: Colors.red,
            );
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Container(
                      child: Text(
                        'Sign Up',
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: AppColor.primerColor,
                                ),
                      ),
                    ),
                  ),
                  AppSize.sv_40,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //user name
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFiledComponent(
                                  keyboardType: TextInputType.name,
                                  controller: firstNameController,
                                  hintText: 'first name',
                                  prefixIcon: Icons.person,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              AppSize.sh_10,
                              Expanded(
                                child: TextFormFiledComponent(
                                  controller: lastNameController,
                                  hintText: 'last name',
                                  prefixIcon: Icons.person,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          AppSize.sv_10,
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFiledComponent(
                                  controller: addressController,
                                  hintText: 'address',
                                  prefixIcon: Icons.add_location,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your address';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              AppSize.sh_10,
                              Expanded(
                                child: TextFormFiledComponent(
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,
                                  hintText: 'phone',
                                  prefixIcon: Icons.phone,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your phone';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          AppSize.sv_10,
                          TextFormFiledComponent(
                            controller: userController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'User Name',
                            prefixIcon: Icons.person,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your user name';
                              }
                              return null;
                            },
                          ),
                          AppSize.sv_10,
                          TextFormFiledComponent(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Email',
                            prefixIcon: Icons.email,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          AppSize.sv_10,
                          TextFormFiledComponent(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: 'Password',
                            prefixIcon: Icons.lock,
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSize.sv_50,
                  state is AuthRegistrationLoadingState ||
                          state is AuthAssignRoleLoadingState
                      ? const BuildCircularWidget()
                      : Center(
                          child: BottomComponent(
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColor.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.userAuthRegistrationDio(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  address: addressController.text,
                                  phone: phoneController.text,
                                  userName: userController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                        ),
                  AppSize.sv_5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routers.LOGIN,
                          (route) => false,
                        ),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
