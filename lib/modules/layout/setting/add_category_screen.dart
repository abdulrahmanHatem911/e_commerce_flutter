import 'package:e_commerce_flutter/modules/widgets/build_circular_widget.dart';
import 'package:e_commerce_flutter/modules/widgets/build_flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/screen_config.dart';
import '../../../models/category_model.dart';
import '../../widgets/bottom_app.dart';
import '../../widgets/text_form_filed.dart';

class AddCategoryScreen extends StatefulWidget {
  final String? edit;
  final CategoryModel? model;
  const AddCategoryScreen({super.key, this.edit, this.model});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController imageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // check if the user is editing or adding a new product
  bool get isEditing => widget.edit == 'edit';
  @override
  void initState() {
    if (isEditing) {
      nameController.text = widget.model!.name;
      imageController.text = widget.model!.imageUrl;
    } else {
      nameController.text = '';
      imageController.text = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            isEditing ? 'Update Category' : 'Add Category',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {
            if (state is LayoutAddCategorySuccessState) {
              showFlutterToast(
                message: 'Category Added Successfully',
                toastColor: Colors.green,
              );
            }
            if (state is LayoutAddCategoryErrorState) {
              showFlutterToast(
                message: state.error.toString(),
                toastColor: Colors.red,
              );
            }
            if (state is LayoutUpdateCategorySuccessState) {
              showFlutterToast(
                message: 'Category Updated Successfully',
                toastColor: Colors.green,
              );
            }
            if (state is LayoutUpdateCategoryErrorState) {
              showFlutterToast(
                message: state.error.toString(),
                toastColor: Colors.red,
              );
            }
          },
          builder: (context, state) {
            LayoutCubit cubit = LayoutCubit.get(context);
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.6,
                          height: SizeConfig.screenHeight * 0.36,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImage.addProduct),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        AppSize.sv_10,
                        TextFormFiledComponent(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          hintText: 'Name',
                          prefixIcon: Icons.title,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Product Name';
                            }
                            return null;
                          },
                        ),
                        AppSize.sv_10,
                        TextFormFiledComponent(
                          keyboardType: TextInputType.text,
                          controller: imageController,
                          hintText: 'Image url',
                          prefixIcon: Icons.image,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Product image url';
                            }
                            return null;
                          },
                        ),
                        AppSize.sv_20,
                        state is LayoutAddCategoryLoadingState ||
                                state is LayoutUpdateCategoryLoadingState
                            ? const BuildCircularWidget()
                            : BottomComponent(
                                child: Text(
                                  isEditing
                                      ? 'Update Category'
                                      : 'Add Category',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (isEditing) {
                                      cubit.updateCategory(
                                        id: widget.model!.id,
                                        name: nameController.text,
                                        image: imageController.text,
                                      );
                                    } else {
                                      cubit.addCategoryDio(
                                        name: nameController.text,
                                        image: imageController.text,
                                      );
                                    }
                                  }
                                },
                              ),
                        AppSize.sv_10,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
