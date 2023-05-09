import 'package:e_commerce_flutter/core/services/cache_helper.dart';
import 'package:e_commerce_flutter/core/utils/constent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../core/style/icon_broken.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/screen_config.dart';
import '../../../core/widget/circular_progress_component.dart';
import '../../widgets/cart/botton_pay.dart';
import '../../widgets/text_form_filed.dart';
import 'toggle_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int? price;
  PaymentScreen({super.key, this.price});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firstNameController.text = CURRENT_USER?.firstName ?? '';
    lastNameController.text = CURRENT_USER?.lastName ?? '';
    emailController.text = "${CacheHelper.getData(key: 'email')}" == null
        ? ''
        : "${CacheHelper.getData(key: 'email')}";
    phoneController.text = CURRENT_USER?.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is PaymentRequestTokenSuccessStates) {
          CircularProgressComponent.showSnackBar(
            context: context,
            message: 'Payment Success',
            color: Colors.green,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ToggleScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(elevation: 0.0, title: const Text('Payment')),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.4,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(AppImage.emptyImage),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormFiledComponent(
                          controller: firstNameController,
                          keyboardType: TextInputType.name,
                          hintText: 'Enter your name',
                          prefixIcon: IconBroken.Profile,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        AppSize.sv_10,
                        TextFormFiledComponent(
                          controller: lastNameController,
                          keyboardType: TextInputType.name,
                          hintText: 'Enter your last name',
                          prefixIcon: IconBroken.Profile,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        AppSize.sv_10,
                        TextFormFiledComponent(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Enter your email',
                          prefixIcon: IconBroken.Message,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        AppSize.sv_10,
                        TextFormFiledComponent(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          hintText: 'Enter your phone',
                          prefixIcon: IconBroken.Call,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            child: BottomPayment(
              text: 'Payment Processes ',
              totalPrice: widget.price.toString(),
              onTap: () {
                // test the toggal screen
                if (_formKey.currentState!.validate()) {
                  cubit.getOrderRegistrationID(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    price: (widget.price! * 100).toString(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
