class AppConstants {
  static const String APP_NAME = "DELEVERY_APP";
  static const int APP_VERSION = 1;

  //"http://10.0.2.2:8000"
  static const String BASE_URL = "http://localhost:8000";
  //http://127.0.0.1:8000  -> local host
  static const String POPULAR_PRODUCTS_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCTS_URI = "/api/v1/products/recommended";
  static const String UPLOADE_URI = "/uploads/";

  //User and Auth URI
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  static const String TOKEN = "";
  static const String NUMBER = "";
  static const String PASSWORD = "";

  //shared preferences local storage
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}
