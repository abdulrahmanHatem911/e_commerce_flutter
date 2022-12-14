import 'package:e_commerce_flutter/core/network/remote/api_constant.dart';
import 'package:e_commerce_flutter/core/network/remote/dio_helper.dart';
import 'package:e_commerce_flutter/core/services/cache_helper.dart';
import 'package:e_commerce_flutter/models/category_model.dart';
import 'package:e_commerce_flutter/models/product_model.dart';
import 'package:e_commerce_flutter/modules/screens/cart/cart_sreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/network/local/sql_server.dart';
import '../../modules/screens/navigation/categories_screen.dart';
import '../../modules/screens/navigation/favorite_screen.dart';
import '../../modules/screens/navigation/home_screen.dart';
import '../../modules/screens/navigation/setting_screen.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(context) => BlocProvider.of<LayoutCubit>(context);

  int currentIndex = 2;
  List<Widget> screens = [
    const CartScreen(),
    const FavoriteScreen(),
    HomeScreen(),
    const CategoriesScreen(),
    const SettingScreen(),
  ];
  List<String> titles = [
    'Cart',
    'Favorite',
    'Home',
    'Categories',
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
    DioHelper.getData(url: ApiConstant.GET_PRODUCTS).then((value) {
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
      print('success Mdhat🐺');
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutGetProductErrorState(error.toString()));
    });
  }

  //get category
  List<CategoryModel> categories = [];
  var admin = CacheHelper.getData(key: 'admin');
  void getCategoryDio() {
    emit(LayoutGetCategoryLoadingState());
    DioHelper.getData(url: ApiConstant.GET_CATEGORIES).then((value) {
      if (admin != null && admin != '') {
        value.data.forEach((element) {
          categories.add(CategoryModel.fromJson(element));
        });
      } else {
        value.data.forEach((element) {
          if (element['isActive'] == true) {
            categories.add(CategoryModel.fromJson(element));
          }
        });
      }
      emit(LayoutGetCategorySuccessState());
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutGetCategoryErrorState(error.toString()));
    });
  }

  //get produt by category id
  List<ProductModel> productsByCategoryId = [];
  void getProductByCategoryIdDio({required int categoryId}) {
    emit(LayoutGetProductByCategoryIdLoadingState());
    DioHelper.getData(url: ApiConstant.PRODUCT_BY_CATEGORIES_ID(categoryId))
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

  //--use database to inset item to favorite
  //insert to database
  void insertToFavorites(ProductModel model) {
    SqliteService().createItem(model).then((value) {
      getFromDatabase();
      emit(LayoutInsertToDatabaseState());
    });
  }

  //get from database
  List<ProductModel> databaseFavoritesProducts = [];
  void getFromDatabase() {
    SqliteService().getAllItems().then((value) {
      databaseFavoritesProducts = value;
      emit(LayoutGetFromDatabaseState());
    });
  }

  //search from database
  bool isFavoriteFromDatabase(int productId) {
    return databaseFavoritesProducts.any((element) => element.id == productId);
  }

  //search
  List<ProductModel> searchProducts = [];
  void searchForProduct(String productName) {
    emit(LayoutSearchLoadingState());
    DioHelper.getData(url: ApiConstant.SEARCH_PRODUCT(productName))
        .then((value) {
      searchProducts = [];
      value.data.forEach((element) {
        searchProducts.add(ProductModel.fromJson(element));
      });
      print("Success get search produces 🚀");
      emit(LayoutSearchSuccessState());
    }).catchError((error) {
      searchProducts = [];
      print("error:🤔${error.toString()}");
      emit(LayoutSearchErrorState(error.toString()));
    });
  }

  // add product to cart

  void getCartItems() async {
    emit(LayoutGetCartItemsLoadingState());
    DioHelper.getDataUseToken(
      url: ApiConstant.GET_CART_ITEMS(CacheHelper.getData(key: 'id')),
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print('success get cart items');
      emit(LayoutGetCartItemsSuccessState());
    }).catchError((error) {
      print('error get cart items');
      emit(LayoutGetCartItemsErrorState(error.toString()));
    });
  }
}
