import 'package:delevery_app/controllers/cart_controller.dart';
import 'package:delevery_app/pages/Home/home_page_body.dart';
import 'package:delevery_app/pages/auth/sign_in_page.dart';
import 'package:delevery_app/pages/auth/sign_up_page.dart';
import 'package:delevery_app/pages/cart/cart_page.dart';
import 'package:delevery_app/pages/splash/splash_page.dart';
import 'package:delevery_app/routes/rout_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dcdg/dcdg.dart';
import 'controllers/popular_product_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          //home: SignInPage(),//SignUpPage(),
           initialRoute: RouteHelper.getSplash(),
           getPages: RouteHelper.routes ,
        );
      });
    });
  }
}

