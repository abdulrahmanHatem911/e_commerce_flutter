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
import '../../modules/layout/setting_screen.dart';

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
  List<ProductModel> manProducts = [];
  List<ProductModel> womanProducts = [];
  List<ProductModel> jewelery = [];
  void getProductDio() {
    emit(LayoutGetProductLoadingState());
    DioHelper.getData(url: ApiConstant.GET_PRODUCTS).then((value) {
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
    DioHelper.getDataUseToken(
      url: ApiConstant.PRODUCT_BY_CATEGORIES_ID(categoryId),
      token: "${CacheHelper.getData(key: 'token')}",
    ).then((value) {
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

  // payment method

  // for authentication in paymob
  AuthenticationRequestModel? authTokenModel;

// for authentication in paymob
  CacheHelper cacheHelper = CacheHelper();
  var totalPrice = CacheHelper.getData(key: 'total_price');
  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingStates());
    DioHelper.postData(url: ApiConstant.authTokenUrl, data: {
      'api_key': ApiConstant.paymentApiKey,
    }).then((value) {
      authTokenModel = AuthenticationRequestModel.fromJson(value.data);
      ApiConstant.paymentFirstToken = authTokenModel!.token;
      print('The token 🍅');
      print("the value total Price is $totalPrice");
      emit(PaymentAuthSuccessStates());
    }).catchError((error) {
      print('Error in auth token 🤦‍♂️');
      emit(
        PaymentAuthErrorStates(error.toString()),
      );
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

  // for final request token

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

  //sign out
  Future<void> userSignOutDio() async {
    await CacheHelper.saveData(key: 'user', value: '');
    await CacheHelper.saveData(key: 'token', value: '');
    emit(UserSignOutSuccessState());
  }
}
