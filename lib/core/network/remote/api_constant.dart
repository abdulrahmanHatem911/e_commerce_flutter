class ApiConstant {
  static const String BASE_URL =
      "http://ecommerce36-001-site1.gtempurl.com/api";

  static const String REGISTER = "$BASE_URL/AuthUser/Register";
  static const String LOGIN = "$BASE_URL/AuthUser/Login";
  static const String ASSIGN_ROLE = "$BASE_URL/Admin/AssignRole";

  static const String GET_PRODUCTS = "$BASE_URL/Product/GetProducts";
  static String ADD_PRODUCT = "$BASE_URL/Product/AddProduct";
  static String PRODUCT_BY_CATEGORIES_ID(int categoryId) =>
      "$BASE_URL/Product/GetByCategoryId/$categoryId";
  static String UPDATE_PRODUCT(int productId) =>
      "$BASE_URL/Product/UpdateProduct/$productId";
  static String DELETE_PRODUCT(int productId) =>
      "$BASE_URL/Product/DeletProduct/$productId";
  static String SEARCH_PRODUCT(String productName) =>
      "$BASE_URL/Product/Search/$productName";
  //cart
  static String GET_CART_ITEMS(int userId) => "/api/Cart/GetItems/$userId";
  static String ADD_TO_CART = "/api/Cart";
  static String CART_ITEM(int cartItemId) => "/api/Cart/$cartItemId";
  static String DELETE_CART_ITEM(int cartItemId) => "/api/Cart/$cartItemId";
  static String UPDATE_CART_ITEM(int updateCartId) => "/api/Cart/$updateCartId";

//profile
  static String GET_PROFILE(String userEmail) =>
      "$BASE_URL/ProfileSetting/GetProfileToUpdate/$userEmail";
  static String UPDATE_PROFILE(String userEmail) =>
      "$BASE_URL/ProfileSetting/UpdateProfile/$userEmail";

  //category
  static const String GET_CATEGORIES = "$BASE_URL/Category/GetAllCategories";
  static const String ADD_CATEGORY = "$BASE_URL/Category/AddCategory";
  static String UPDATE_CATEGORY(int categoryId) =>
      "$BASE_URL/Category/UpdateCategory/$categoryId";
  static String DELETE_CATEGORY(int categoryId) =>
      "$BASE_URL/Category/DeleteCategory/$categoryId";

  //payment method
  static const String baseUrl = 'https://accept.paymob.com/api';
  static const String paymentApiKey =
      "ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SndjbTltYVd4bFgzQnJJam95TXpNM056UXNJbTVoYldVaU9pSXhOamN4TURBeU5qQXlMalF3TlRVMk9TSXNJbU5zWVhOeklqb2lUV1Z5WTJoaGJuUWlmUS5Ld3FYY2Uwdk1xbkJHR0UyUDlXQktCRXFyOXNQWElQWXlWYmhOVXZPUDVjUnAzN3Z0TWlBNWkzR3JBNTVQd3E0VG96RTJfNnpHQThkQ2QwQ091dmNtUQ==";
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

  static const String integrationIdCard = '2363536';
  static const String integrationIdKiosk = '2363564';

  static String refCode = '';
}
