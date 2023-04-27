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
import '../../modules/layout/cart/cart_sreen.dart';
import '../../modules/layout/categories_screen.dart';
import '../../modules/layout/favorite_screen.dart';
import '../../modules/layout/home_screen.dart';
import '../../modules/layout/setting/setting_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
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

  // get product
  List<ProductModel> products = [];
  List<ProductModel> manProducts = [];
  List<ProductModel> womanProducts = [];
  List<ProductModel> jewelery = [];
  void getAllProduct() {
    emit(LayoutGetProductLoadingState());
    DioHelper.getData(url: ApiConstant.GET_PRODUCTS).then((value) {
      products.clear();
      manProducts.clear();
      womanProducts.clear();
      jewelery.clear();
      value.data.forEach((element) {
        if (element['category']['name'] == 'jewelery') {
          jewelery.add(ProductModel.fromJson(element));
        } else if (element['category']['name'] == 'Man') {
          manProducts.add(ProductModel.fromJson(element));
        } else if (element['category']['name'] == 'Woman') {
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
    DioHelper.getDataUseToken(
      url: ApiConstant.PRODUCT_BY_CATEGORIES_ID(categoryId),
      token: "${CacheHelper.getData(key: 'token')}",
    ).then((value) {
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
    DioHelper.postDataUseToken(
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
      emit(LayoutAddProductErrorState("error is ${error.toString()}"));
    });
  }

  List<CategoryModel> categories = [];
  void getAllCategory() {
    emit(LayoutGetCategoryLoadingState());
    DioHelper.getData(url: ApiConstant.GET_CATEGORIES).then((value) {
      categories.clear();
      value.data.forEach((element) {
        categories.add(CategoryModel.fromJson(element));
      });
      emit(LayoutGetCategorySuccessState());
    }).catchError((error) {
      emit(LayoutGetCategoryErrorState("error:🤔 ${error.toString()}"));
    });
  }

  void addCategoryDio({required String name, required String image}) {
    emit(LayoutAddCategoryLoadingState());
    DioHelper.postDataUseToken(
      url: ApiConstant.ADD_CATEGORY,
      token: "${CacheHelper.getData(key: 'token')}",
      data: {
        "name": name,
        "imageURL": image,
        "isActive": true,
      },
    ).then((value) {
      getAllCategory();
      emit(LayoutAddCategorySuccessState());
    }).catchError((error) {
      print("error:🤔${error.toString()}");
      emit(LayoutAddCategoryErrorState(error.toString()));
    });
  }

  List<ProductModel> searchProducts = [];
  void searchForProduct(String productName) {
    emit(LayoutSearchLoadingState());
    DioHelper.getDataUseToken(
      url: ApiConstant.SEARCH_PRODUCT(productName),
      token: "${CacheHelper.getData(key: 'token')}",
    ).then((value) {
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

  void getCartItems() async {
    emit(LayoutGetCartItemsLoadingState());
    DioHelper.getDataUseToken(
      url: ApiConstant.GET_CART_ITEMS(CacheHelper.getData(key: 'id')),
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      emit(LayoutGetCartItemsSuccessState());
    }).catchError((error) {
      emit(LayoutGetCartItemsErrorState(error.toString()));
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
    DioHelper.postData(url: ApiConstant.authTokenUrl, data: {
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
    DioHelper.postData(url: ApiConstant.orderRegistrationIDUrl, data: {
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
    DioHelper.postData(
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
    DioHelper.postData(
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

  Future<void> userSignOutDio() async {
    await CacheHelper.saveData(key: 'user', value: '');
    await CacheHelper.saveData(key: 'token', value: '');
    emit(UserSignOutSuccessState());
  }
}
