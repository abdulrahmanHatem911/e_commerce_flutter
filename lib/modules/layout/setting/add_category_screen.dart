import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/screen_config.dart';
import '../../../core/widget/circular_progress_component.dart';
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
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            isEditing ? 'Edit Category' : 'Add Category',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Center(
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
                    AppSize.sv_10,
                    BlocConsumer<LayoutCubit, LayoutState>(
                      listener: (context, state) {
                        if (state is LayoutAddCategorySuccessState) {
                          CircularProgressComponent.showSnackBar(
                            context: context,
                            message: "Success add/edit category",
                            color: Colors.green,
                          );
                        }
                        if (state is LayoutAddCategoryErrorState) {
                          CircularProgressComponent.showSnackBar(
                            context: context,
                            message: "Error add/edit category",
                            color: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        var cubit = LayoutCubit.get(context);
                        return BottomComponent(
                          child: state is LayoutAddProductLoadingState
                              ? const CircularProgressComponent()
                              : Text(
                                  isEditing ? 'Edit Category' : 'Add Category',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (isEditing) {
                                // cubit.updateCategoryDio(
                                //   id: widget.model!.id,
                                //   name: nameController.text,
                                //   image: imageController.text,
                                //   isActive: isActiveController.text,
                                // );
                              } else {
                                cubit.addCategoryDio(
                                  name: nameController.text,
                                  image: imageController.text,
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                    AppSize.sv_20,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
