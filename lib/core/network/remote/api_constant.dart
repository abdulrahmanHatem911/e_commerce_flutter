class ApiConstant {
  static const String BASE_URL =
      "http://ecommerce925-001-site1.atempurl.com/api";

  //Authorization
  static const String REGISTER = "$BASE_URL/AuthUser/Register";
  static const String LOGIN = "$BASE_URL/AuthUser/Login";

  //productes
  static const String GET_PRODUCTS = "$BASE_URL/Product/GetProducts";
  static String ADD_PRODUCT = "$BASE_URL/Product/AddProduct";
  static String PRODUCT_BY_CATEGORIES_ID(int categoryId) =>
      "$BASE_URL/Product/GetByCategoryId/$categoryId";
  static String UPDATE_PRODUCT(int productId) => "/api/Product/$productId";
  static String DELETE_PRODUCT(int productId) => "/api/Product/$productId";
  static String SEARCH_PRODUCT(String productName) =>
      "$BASE_URL/Product/Search/$productName";
  //cart
  static String GET_CART_ITEMS(int userId) => "/api/Cart/GetItems/$userId";
  static String ADD_TO_CART = "/api/Cart";
  static String CART_ITEM(int cartItemId) => "/api/Cart/$cartItemId";
  static String DELETE_CART_ITEM(int cartItemId) => "/api/Cart/$cartItemId";
  static String UPDATE_CART_ITEM(int updateCartId) => "/api/Cart/$updateCartId";

  //category
  static const String GET_CATEGORIES = "$BASE_URL/Category/GetAllCategories";
  static const String ADD_CATEGORY = "$BASE_URL/Category/AddCategory";
  static String UPDATE_CATEGORY(int categoryId) => "/api/Category/$categoryId";
  static String DELETE_CATEGORY(int categoryId) => "/api/Category/$categoryId";
  //

  //payment method
  static const String baseUrl = 'https://accept.paymob.com/api';
  static const String paymentApiKey = "";
  static const String authTokenUrl = "$baseUrl/auth/tokens";
  static const String orderRegistrationIDUrl = "$baseUrl/ecommerce/orders";
  static const String paymentRequestTokenUrl =
      "$baseUrl/acceptance/payment_keys";
  static const String refCodeUrl = "$baseUrl/acceptance/payments/pay";
  static String visaUrl =
      'https://accept.paymob.com/api/acceptance/iframes/424000?payment_token=$finalToken';
  static String paymentFirstToken = '';

  static String paymentOrderId = '';

  static String finalToken = '';

  static const String integrationIdCard = '    ';
  static const String integrationIdKiosk = '';

  static String refCode = '';
}
