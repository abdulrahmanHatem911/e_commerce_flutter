class ApiConstant {
  // for emulator use 10.0.2.2
  static const String BASE_URL = "https://10.0.2.2:7159";

  // for real device use your ip address
  //static const String BASE_URL = "https://0.0.0.0:7159";
  static const String REGISTER = "/api/Users/Register";
  static const String LOGIN = "/api/Users/Login";

  static const String GET_PRODUCTS = "/api/Product";
  static String ADD_PRODUCT = "/api/Product";
  static String PRODUCT_BY_CATEGORIES_ID(int categoryId) =>
      "/api/Product/GetByCategoryId/$categoryId";
  static String UPDATE_PRODUCT(int productId) => "/api/Product/$productId";
  static String DELETE_PRODUCT(int productId) => "/api/Product/$productId";
  static String SEARCH_PRODUCT(String productName) =>
      "/api/Product/Search/$productName";

  //cart
  static String GET_CART_ITEMS(int userId) => "/api/Cart/GetItems/$userId";
  static String ADD_TO_CART = "/api/Cart";
  static String CART_ITEM(int cartItemId) => "/api/Cart/$cartItemId";
  static String DELETE_CART_ITEM(int cartItemId) => "/api/Cart/$cartItemId";
  static String UPDATE_CART_ITEM(int updateCartId) => "/api/Cart/$updateCartId";

  //category
  static const String GET_CATEGORIES = "/api/Category";
  static const String ADD_CATEGORY = "/api/Category";
  static String UPDATE_CATEGORY(int categoryId) => "/api/Category/$categoryId";
  static String DELETE_CATEGORY(int categoryId) => "/api/Category/$categoryId";
  //
}
