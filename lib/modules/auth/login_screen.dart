import 'package:e_commerce_flutter/modules/widgets/build_circular_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../controllers/auth_cubit/auth_cubit.dart';
import '../../controllers/auth_cubit/auth_state.dart';
import '../../core/routes/app_routers.dart';
import '../../core/services/cache_helper.dart';
import '../../core/style/app_color.dart';
import '../../core/utils/app_size.dart';
import '../../core/utils/screen_config.dart';
import '../../core/widget/circular_progress_component.dart';
import '../widgets/bottom_app.dart';
import '../widgets/text_form_filed.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSize.sv_80,
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  AppSize.sv_20,
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                        AppSize.sv_20,
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthLoginSuccessState) {
                              CacheHelper.saveData(
                                      key: 'user', value: state.user)
                                  .then((value) {
                                CircularProgressComponent.showSnackBar(
                                  context: context,
                                  message: 'Login Success',
                                  color: Colors.green,
                                );
                                Navigator.pushNamedAndRemoveUntil(context,
                                    Routers.LAYOUT_SCREEN, (route) => false);
                              });
                            }
                            if (state is AuthLoginErrorState) {
                              CircularProgressComponent.showSnackBar(
                                context: context,
                                message: state.error,
                                color: Colors.red,
                              );
                            }
                          },
                          builder: (context, state) {
                            var cubit = AuthCubit.get(context);
                            return state is AuthLoginLoadingState
                                ? const BuildCircularWidget()
                                : BottomComponent(
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.userLoginDio(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                  );
                          },
                        ),
                        //or
                        AppSize.sv_40,
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                  AppSize.sv_30,
                  _buildSocialButton(
                    context: context,
                    text: 'Login with Facebook',
                    icon: FontAwesomeIcons.facebook,
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                  AppSize.sv_10,
                  _buildSocialButton(
                    context: context,
                    text: 'Login with google',
                    icon: FontAwesomeIcons.google,
                    color: Colors.red,
                    onPressed: () {},
                  ),
                  AppSize.sv_10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routers.REGISTER,
                          (route) => false,
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.primerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required String text,
    required Function() onPressed,
    required IconData icon,
    required Color color,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        minimumSize: Size(
          SizeConfig.screenWidth * 0.9,
          SizeConfig.screenHeight * 0.065,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: onPressed,
      icon: FaIcon(
        icon,
        size: 20.0,
        color: color,
      ),
      label: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
