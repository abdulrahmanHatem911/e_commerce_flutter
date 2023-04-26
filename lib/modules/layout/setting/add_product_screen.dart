import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../core/routes/app_routers.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/screen_config.dart';
import '../../../core/widget/circular_progress_component.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../widgets/bottom_app.dart';
import '../../widgets/build_descreption_widget.dart';
import '../../widgets/text_form_filed.dart';

class AddProductScreen extends StatefulWidget {
  final String? edit;
  final ProductModel? productModel;
  const AddProductScreen({super.key, this.edit, this.productModel});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController categoryController = TextEditingController();

  TextEditingController imageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // check if the user is editing or adding a new product
  bool get isEditing => widget.edit == 'edit';
  CategoryModel? categoryModel;
  @override
  void initState() {
    if (isEditing) {
      nameController.text = widget.productModel!.name;
      priceController.text = widget.productModel!.price.toString();
      descriptionController.text = widget.productModel!.description;
      categoryController.text = widget.productModel!.categoryId.toString();
      imageController.text = widget.productModel!.imageUrl.toString();
    } else {
      nameController.text = '';
      priceController.text = '';
      descriptionController.text = '';
      categoryController.text = '';
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
          isEditing ? 'Edit Product' : 'Add Product',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          if (state is LayoutAddProductSuccessState) {
            CircularProgressComponent.showSnackBar(
              context: context,
              message: "Success Add/Edit product ",
              color: Colors.green,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routers.LAYOUT_SCREEN,
              (route) => false,
            );
          }

          if (state is LayoutAddProductErrorState) {
            CircularProgressComponent.showSnackBar(
              context: context,
              message: state.error,
              color: Colors.red,
            );
          }
        },
        builder: (context, state) {
          LayoutCubit layoutCubit = LayoutCubit.get(context);
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
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
                          //color: Colors.amber,
                          image: DecorationImage(
                            image: AssetImage(AppImage.addProduct),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      AppSize.sv_30,
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
                      BuildDescriptionTextFiled(
                        keyboardType: TextInputType.text,
                        controller: descriptionController,
                        hintText: 'Description',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Product description';
                          }
                          return null;
                        },
                      ),
                      AppSize.sv_10,
                      Row(
                        children: [
                          Expanded(
                            child: TextFormFiledComponent(
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              hintText: 'Price',
                              prefixIcon: Icons.monetization_on_outlined,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Product Price';
                                }
                                return null;
                              },
                            ),
                          ),
                          AppSize.sh_10,
                          Expanded(
                            child: Container(
                              width: SizeConfig.screenWidth * 0.88,
                              height: SizeConfig.screenHeight * 0.065,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: DropdownButton<CategoryModel>(
                                value: categoryModel,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                items: layoutCubit.categories
                                    .map((child) => DropdownMenuItem(
                                          value: child,
                                          child: Text(child.name),
                                        ))
                                    .toList(),
                                onChanged: (child) {
                                  setState(() {
                                    categoryModel = child;
                                    categoryController.text =
                                        child!.id.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
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
                      AppSize.sv_30,
                      BottomComponent(
                        child: state is LayoutAddProductLoadingState
                            ? const CircularProgressComponent()
                            : Text(
                                isEditing ? 'Edit Product' : 'Add Product',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (isEditing) {
                              // cubit.updateProductDio(
                              //   id: widget.productModel!.id,
                              //   name: nameController.text,
                              //   price: priceController.text,
                              //   description: descriptionController.text,
                              //   categoryId: categoryController.text,
                              //   image: imageController.text,
                              // );
                            } else {
                              layoutCubit.addProductDio(
                                name: nameController.text,
                                price: priceController.text,
                                description: descriptionController.text,
                                categoryId: categoryController.text,
                                image: imageController.text,
                              );
                            }
                          }
                        },
                      ),
                      AppSize.sv_20,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
