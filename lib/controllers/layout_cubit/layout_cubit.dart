import 'package:e_commerce_flutter/core/network/remote/api_constant.dart';
import 'package:e_commerce_flutter/core/network/remote/dio_helper.dart';
import 'package:e_commerce_flutter/models/category_model.dart';
import 'package:e_commerce_flutter/models/product_model.dart';
import 'package:e_commerce_flutter/modules/screens/navigation/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/screens/navigation/categories_screen.dart';
import '../../modules/screens/navigation/favorite_screen.dart';
import '../../modules/screens/navigation/home_screen.dart';
import '../../modules/screens/navigation/setting_screen.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(context) => BlocProvider.of<LayoutCubit>(context);

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    const CategoriesScreen(),
    const PaymentScreen(),
    const FavoriteScreen(),
    const SettingScreen(),
  ];
  List<String> titles = [
    'Home',
    'Categories',
    'Payment',
    'Favorite',
    'Profile',
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavBarState());
  }

  // get product
  List<ProductModel> products = [];
  List<ProductModel> electronics = [];
  List<ProductModel> clothes = [];
  List<ProductModel> furniture = [];
  List<ProductModel> shoes = [];
  void getProductDio() {
    emit(LayoutGetProductLoadingState());
    DioHelper.getData(url: ApiConstant.PRODUCTS).then((value) {
      value.data.forEach((element) {
        if (element['category']['name'] == 'Clothes') {
          clothes.add(ProductModel.fromJson(element));
        } else if (element['category']['name'] == 'Electronics') {
          electronics.add(ProductModel.fromJson(element));
        } else if (element['category']['name'] == 'Furniture') {
          furniture.add(ProductModel.fromJson(element));
        } else if (element['category']['name'] == 'Shoes') {
          shoes.add(ProductModel.fromJson(element));
        }
        products.add(ProductModel.fromJson(element));
      });
      emit(LayoutGetProductSuccessState());
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutGetProductErrorState(error.toString()));
    });
  }

  //get category
  List<CategoryModel> categories = [];
  void getCategoryDio() {
    emit(LayoutGetCategoryLoadingState());
    DioHelper.getData(url: ApiConstant.CATEGORIES).then((value) {
      value.data.forEach((element) {
        categories.add(CategoryModel.fromJson(element));
      });
      emit(LayoutGetCategorySuccessState());
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutGetCategoryErrorState(error.toString()));
    });
  }

  //get produt by category id
  List<ProductModel> productsByCategoryId = [];
  void getProductByCategoryIdDio(int id) {
    emit(LayoutGetProductByCategoryIdLoadingState());
    DioHelper.getData(url: ApiConstant.PRODUCT_BY_CATEGORIES_ID(id))
        .then((value) {
      value.data.forEach((element) {
        productsByCategoryId.add(ProductModel.fromJson(element));
      });
      print("Success🚀");
      emit(LayoutGetProductByCategoryIdSuccessState());
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutGetProductByCategoryIdErrorState(error.toString()));
    });
  }
}
