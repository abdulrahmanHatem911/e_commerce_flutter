class ApiConstant {
  static const String BASE_URL = "https://10.0.2.2:7159";
  static const String REGISTER = "/api/Users/Register";
  static const String LOGIN = "/api/Users/Login";
  static const String PRODUCTS = "/api/Product";
  static String PRODUCT_BY_CATEGORIES_ID(int categoryId) =>
      "/api/Product/GetByCategoryId/$categoryId";
  static const String CATEGORIES = "/api/Category";
}
