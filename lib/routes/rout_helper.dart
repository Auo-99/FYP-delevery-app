
import 'package:delevery_app/pages/auth/sign_in_page.dart';
import 'package:delevery_app/pages/cart/cart_page.dart';
import 'package:get/get.dart';

import '../pages/Food/popular_food_detail.dart';
import '../pages/Food/recommended_food_detail.dart';
import '../pages/Home/home_page.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splash = "/splash";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signInPage = "/sign-in-page";

  static String getInitial() => '$initial';
  static String getSplash() => '$splash';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=> '$cartPage';
  static String getSignInPage()=> '$signInPage';

  static List<GetPage> routes = [
    GetPage(name: splash, page: ()=> SplashScreen()),
    GetPage(name: initial, page: ()=> HomePage()),
    GetPage(name: signInPage, page: ()=> SignInPage(), transition: Transition.fade),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page:page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!), page:page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(name: cartPage, page: ()=>CartPage(),transition: Transition.fadeIn),
  ];
}
