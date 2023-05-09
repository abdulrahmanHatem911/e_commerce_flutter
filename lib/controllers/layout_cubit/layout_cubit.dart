import 'package:e_commerce_flutter/core/utils/constent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/network/local/sql_server.dart';
import '../../core/network/remote/api_constant.dart';
import '../../core/network/remote/dio_helper.dart';
import '../../core/services/cache_helper.dart';
import '../../models/category_model.dart';
import '../../models/payment/authentication_request_model.dart';
import '../../models/payment/order_registration_model.dart';
import '../../models/payment/payment_reqeust_model.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../modules/layout/cart/cart_sreen.dart';
import '../../modules/layout/categories_screen.dart';
import '../../modules/layout/favorite_screen.dart';
import '../../modules/layout/home_screen.dart';
import '../../modules/layout/setting/setting_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  final DioHelper dioHelper;
  LayoutCubit({required this.dioHelper}) : super(LayoutInitial());
  static LayoutCubit get(context) => BlocProvider.of<LayoutCubit>(context);
  int currentIndex = 2;
  List<Widget> screens = [
    const CartScreen(),
    const FavoriteScreen(),
    const HomeScreen(),
    const CategoriesScreen(),
    const SettingScreen()
  ];
  List<String> titles = ['Cart', 'Favorite', 'Home', 'Categories', 'Profile'];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavBarState());
  }

  List<ProductModel> products = [];
  List<ProductModel> manProducts = [];
  List<ProductModel> womanProducts = [];
  List<ProductModel> jewelery = [];
  void getAllProduct() {
    emit(LayoutGetProductLoadingState());
    DioHelper().fetchData(url: ApiConstant.GET_PRODUCTS).then((value) {
      products.clear();
      manProducts.clear();
      womanProducts.clear();
      jewelery.clear();
      value.data.forEach((element) {
        if (element['category']['id'] == 3) {
          jewelery.add(ProductModel.fromJson(element));
        } else if (element['category']['id'] == 1) {
          manProducts.add(ProductModel.fromJson(element));
        } else if (element['category']['id'] == 2) {
          womanProducts.add(ProductModel.fromJson(element));
        }
        products.add(ProductModel.fromJson(element));
      });
      emit(LayoutGetProductSuccessState());
    }).catchError((error) {
      if (error.toString().contains('SocketException')) {
        emit(LayoutGetProductErrorState('No Internet Connection'));
      } else {
        emit(LayoutGetProductErrorState(error.toString()));
      }
    });
  }

  List<ProductModel> productsByCategoryId = [];
  void getProductByCategoryId({required int categoryId}) {
    emit(LayoutGetProductByCategoryIdLoadingState());
    dioHelper
        .fetchData(
      url: ApiConstant.PRODUCT_BY_CATEGORIES_ID(categoryId),
      token: "${CacheHelper.getData(key: 'token')}",
    )
        .then((value) {
      value.data.forEach((element) {
        productsByCategoryId.add(ProductModel.fromJson(element));
      });
      emit(LayoutGetProductByCategoryIdSuccessState());
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutGetProductByCategoryIdErrorState(error.toString()));
    });
  }

  void addProductDio({
    required String name,
    required String description,
    required String image,
    required String price,
    required String categoryId,
  }) {
    emit(LayoutAddProductLoadingState());
    dioHelper.postData(
      url: ApiConstant.ADD_PRODUCT,
      token: "${CacheHelper.getData(key: 'token')}",
      data: {
        "name": name,
        "description": description,
        "imageURL": image,
        "price": double.parse(price),
        "categoryId": int.parse(categoryId),
      },
    ).then((value) {
      getAllProduct();
      emit(LayoutAddProductSuccessState());
    }).catchError((error) {
      if (error.toString().contains('SocketException')) {
        emit(LayoutAddProductErrorState('No Internet Connection'));
      } else if (error.toString().contains('HttpException')) {
        emit(LayoutAddProductErrorState('Server Not Found'));
      } else if (error.toString().contains('FormatException')) {
        emit(LayoutAddProductErrorState('Invalid Data'));
      } else if (error.toString().contains('404')) {
        emit(LayoutAddProductErrorState('404 Server Not Found'));
      } else if (error.toString().contains('400')) {
        emit(LayoutAddProductErrorState('400 Bad Request'));
      } else {
        emit(LayoutAddProductErrorState("error is ${error.toString()}"));
      }
    });
  }

  void deleteProduct(int id) {
    dioHelper
        .deleteData(
      url: ApiConstant.DELETE_PRODUCT(id),
      data: {},
      token: "${CacheHelper.getData(key: 'token')}",
    )
        .then((value) {
      getAllProduct();
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutDeleteProductErrorState(error.toString()));
    });
  }

  void updateProductDio({
    required int id,
    required String name,
    required String description,
    required String image,
    required String price,
    required String categoryId,
  }) {
    emit(LayoutUpdateProductLoadingState());
    dioHelper.updateData(
      url: ApiConstant.UPDATE_PRODUCT(id),
      token: "${CacheHelper.getData(key: 'token')}",
      data: {
        "name": name,
        "description": description,
        "imageURL": image,
        "price": double.parse(price),
        "categoryId": int.parse(categoryId),
      },
    ).then((value) {
      getAllProduct();
      emit(LayoutUpdateProductSuccessState());
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutUpdateProductErrorState(error.toString()));
    });
  }

  List<CategoryModel> categories = [];
  void getAllCategory() {
    emit(LayoutGetCategoryLoadingState());
    dioHelper.fetchData(url: ApiConstant.GET_CATEGORIES).then((value) {
      categories.clear();
      value.data.forEach((element) {
        categories.add(CategoryModel.fromJson(element));
      });
      emit(LayoutGetCategorySuccessState());
    }).catchError((error) {
      emit(LayoutGetCategoryErrorState("error:🤔 ${error.toString()}"));
    });
  }

  void addCategoryDio({required String name, required String image}) async {
    emit(LayoutAddCategoryLoadingState());
    await dioHelper.postData(
      url: ApiConstant.ADD_CATEGORY,
      token: "${CacheHelper.getData(key: 'token')}",
      data: {
        "name": name,
        "imageURL": image,
        "isActive": true,
      },
    ).then((value) {
      emit(LayoutAddCategorySuccessState());
      getAllCategory();
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutAddCategoryErrorState(error.toString()));
    });
  }

  Future<void> updateCategory({
    required int id,
    required String name,
    required String image,
  }) async {
    emit(LayoutUpdateCategoryLoadingState());
    dioHelper.updateData(
      url: ApiConstant.UPDATE_CATEGORY(id),
      token: "${CacheHelper.getData(key: 'token')}",
      data: {"name": name, "imageURL": image, "isActive": true},
    ).then((value) {
      emit(LayoutUpdateCategorySuccessState());
      getAllCategory();
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutUpdateCategoryErrorState(error.toString()));
    });
  }

  void deleteCategory(int id) {
    emit(LayoutDeleteCategoryLoadingState());
    dioHelper
        .deleteData(
      url: ApiConstant.DELETE_CATEGORY(id),
      data: {},
      token: "${CacheHelper.getData(key: 'token')}",
    )
        .then((value) {
      getAllCategory();
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutDeleteCategoryErrorState(error.toString()));
    });
  }

  List<ProductModel> searchProducts = [];
  void searchForProduct(String productName) {
    emit(LayoutSearchLoadingState());
    dioHelper
        .fetchData(
      url: ApiConstant.SEARCH_PRODUCT(productName),
      token: "${CacheHelper.getData(key: 'token')}",
    )
        .then((value) {
      searchProducts = [];
      value.data.forEach((element) {
        searchProducts.add(ProductModel.fromJson(element));
      });
      emit(LayoutSearchSuccessState());
    }).catchError((error) {
      searchProducts = [];
      emit(LayoutSearchErrorState(error.toString()));
    });
  }

  void insertToFavorites(ProductModel model) {
    SqliteServiceDatabase().createItem(model).then((value) {
      getAllFavorites();
      emit(LayoutInsertToDatabaseState());
    });
  }

  List<ProductModel> databaseFavoritesProducts = [];
  void getAllFavorites() {
    databaseFavoritesProducts = [];
    SqliteServiceDatabase().getAllFavoritesItems().then((value) {
      databaseFavoritesProducts = value;
      emit(LayoutGetFromDatabaseState());
    });
  }

  bool isFavoriteFromDatabase(int productId) {
    return databaseFavoritesProducts.any((element) => element.id == productId);
  }

  AuthenticationRequestModel? authTokenModel;
  var totalPrice = CacheHelper.getData(key: 'total_price');
  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingStates());
    dioHelper.postData(url: ApiConstant.authTokenUrl, data: {
      'api_key': ApiConstant.paymentApiKey,
    }).then((value) {
      authTokenModel = AuthenticationRequestModel.fromJson(value.data);
      ApiConstant.paymentFirstToken = authTokenModel!.token;
      emit(PaymentAuthSuccessStates());
    }).catchError((error) {
      emit(PaymentAuthErrorStates('Error in auth token ${error.toString()}'));
    });
  }

  Future getOrderRegistrationID({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    print('price is $price');
    emit(PaymentOrderIdLoadingStates());
    dioHelper.postData(url: ApiConstant.orderRegistrationIDUrl, data: {
      'auth_token': ApiConstant.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": [],
    }).then((value) {
      OrderRegistrationModel orderRegistrationModel =
          OrderRegistrationModel.fromJson(value.data);
      ApiConstant.paymentOrderId = orderRegistrationModel.id.toString();
      getPaymentRequest(price, firstName, lastName, email, phone);
      print("the value totlePrice is 🍅 $totalPrice");
      print('The order id 🍅 =${ApiConstant.paymentOrderId}');
      emit(PaymentOrderIdSuccessStates());
    }).catchError((error) {
      print('Error in order id 🤦‍♂️');
      emit(
        PaymentOrderIdErrorStates(error.toString()),
      );
    });
  }

  Future<void> getPaymentRequest(
    String priceOrder,
    String firstName,
    String lastName,
    String email,
    String phone,
  ) async {
    emit(PaymentRequestTokenLoadingStates());
    dioHelper.postData(
      url: ApiConstant.paymentRequestTokenUrl,
      data: {
        "auth_token": ApiConstant.paymentFirstToken,
        "amount_cents": priceOrder,
        "expiration": 3600,
        "order_id": ApiConstant.paymentOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": ApiConstant.integrationIdCard,
        "lock_order_when_paid": "false"
      },
    ).then((value) {
      PaymentRequestModel paymentRequestModel =
          PaymentRequestModel.fromJson(value.data);
      ApiConstant.finalToken = paymentRequestModel.token;
      print('Final token 🚀 ${ApiConstant.finalToken}');
      emit(PaymentRequestTokenSuccessStates());
    }).catchError((error) {
      print('Error in final token 🤦‍♂️');
      emit(
        PaymentRequestTokenErrorStates(error.toString()),
      );
    });
  }

  Future getRefCode() async {
    dioHelper.postData(
      url: ApiConstant.refCodeUrl,
      data: {
        "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR",
        },
        "payment_token": ApiConstant.finalToken,
      },
    ).then((value) {
      ApiConstant.refCode = value.data['id'].toString();
      print('The ref code 🍅${ApiConstant.refCode}');
      emit(PaymentRefCodeSuccessStates());
    }).catchError((error) {
      print("Error in ref code 🤦‍♂️");
      emit(PaymentRefCodeErrorStates(error.toString()));
    });
  }

  Future openVisaUrl() async {
    final url = Uri.parse(ApiConstant.visaUrl);
    if (!await launchUrl(
      url,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> getCurrentUser() async {
    emit(GetCurrentUserLoadingState());
    await dioHelper
        .fetchData(
      url: ApiConstant.GET_PROFILE("${CacheHelper.getData(key: 'email')}"),
      token: "${CacheHelper.getData(key: 'token')}",
    )
        .then((value) {
      CURRENT_USER = UserModel.fromJson(value.data);
      emit(GetCurrentUserSuccessState());
    }).catchError((error) {
      print('Error in get current user 🤦‍♂️');
      emit(GetCurrentUserErrorState(error.toString()));
    });
  }

  Future<void> updateUserProfile(UserModel userModel) async {
    emit(UpdateUserProfileLoadingState());
    dioHelper
        .postData(
      url: ApiConstant.UPDATE_PROFILE('${CacheHelper.getData(key: 'email')}'),
      data: userModel.toMap(),
      token: "${CacheHelper.getData(key: 'token')}",
    )
        .then((value) async {
      await getCurrentUser();
      emit(UpdateUserProfileSuccessState());
    }).catchError((error) {
      print('Error in update user profile 🤦‍♂️');
      emit(UpdateUserProfileErrorState(error.toString()));
    });
  }

  Future<void> userSignOutDio() async {
    emit(UserSignOutLoadingState());
    await CacheHelper.saveData(key: 'user', value: '');
    await CacheHelper.saveData(key: 'token', value: '');
    SqliteServiceDatabase().deleteAllItems('cart').then((value) {
      databaseFavoritesProducts.clear();
    });
    SqliteServiceDatabase().deleteAllItems('products').then((value) {
      databaseFavoritesProducts.clear();
      emit(UserSignOutSuccessState());
    });
  }
}
