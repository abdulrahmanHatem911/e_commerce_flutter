import 'package:e_commerce_flutter/controllers/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_flutter/core/utils/app_size.dart';
import 'package:e_commerce_flutter/core/utils/constent.dart';
import 'package:e_commerce_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/utils/screen_config.dart';
import '../../widgets/bottom_app.dart';
import '../../widgets/build_circular_widget.dart';
import '../../widgets/build_flutter_toast.dart';
import '../../widgets/text_form_filed.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    firstNameController.text =
        CURRENT_USER?.firstName == null ? '' : CURRENT_USER!.firstName;
    lastNameController.text =
        CURRENT_USER?.lastName == null ? '' : CURRENT_USER!.lastName;
    addressController.text =
        CURRENT_USER?.address == null ? '' : CURRENT_USER!.address;
    phoneController.text =
        CURRENT_USER?.phone == null ? '' : CURRENT_USER!.phone;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          if (state is UpdateUserProfileSuccessState) {
            showFlutterToast(
                message: 'Update profile successfully 🥳',
                toastColor: Colors.green);

            Navigator.pop(context);
          }
          if (state is UpdateUserProfileErrorState) {
            showFlutterToast(
                message: 'Update profile failed 😥', toastColor: Colors.red);
          }
        },
        builder: (context, state) {
          LayoutCubit layoutCubit = LayoutCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.6,
                      height: SizeConfig.screenHeight * 0.36,
                      decoration: const BoxDecoration(
                        //color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage(AppImage.addProduct),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    TextFormFiledComponent(
                      controller: firstNameController,
                      hintText: 'First Name',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    AppSize.sv_10,
                    TextFormFiledComponent(
                      controller: lastNameController,
                      hintText: 'Last Name',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    AppSize.sv_10,
                    TextFormFiledComponent(
                      controller: addressController,
                      prefixIcon: Icons.location_on,
                      hintText: 'Address',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    AppSize.sv_10,
                    TextFormFiledComponent(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone,
                      hintText: 'Phone',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone';
                        }
                        return null;
                      },
                    ),
                    AppSize.sv_10,
                    state is UpdateUserProfileLoadingState
                        ? BuildCircularWidget()
                        : BottomComponent(
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                layoutCubit.updateUserProfile(
                                  UserModel(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    address: addressController.text,
                                    phone: phoneController.text,
                                  ),
                                );
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
