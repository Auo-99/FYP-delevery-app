import 'package:get/get.dart';

class Dimention {
  //683.428
  // flutter: 932.0
  // flutter: 430.0

  static double screehHeight = Get.context!.height;
  static double screehWidth = Get.context!.width;

  //pageView
  static double pageView = screehHeight / 2.91;
  static double pageViewContainer = screehHeight / 4.23;
  static double pageViewContainerText = screehHeight / 7.76;

  //height size
  static double heigt10 = screehHeight / 93.2;
  static double heigt15 = screehHeight / 62.13;
  static double heigt20 = screehHeight / 46.6;
  static double heigt30 = screehHeight / 31.06;
  static double heigt45 = screehHeight / 20.71;

  //width size
  static double width10 = screehHeight / 93.2;
  static double width15 = screehHeight / 62.13;
  static double width20 = screehHeight / 46.6;
  static double width30 = screehHeight / 31.06;
  static double width45 = screehHeight / 20.71;

  //font
  static double font16 = screehHeight / 58.25;
  static double font20 = screehHeight / 46.6;
  static double font26 = screehHeight / 35.84;

  //icon
  static double icon15 = screehHeight / 62.13;
  static double icon24 = screehHeight / 38.83;

  //ListView Img & container size for Popular section
  static double listViewImgSize = screehHeight / 7.76;
  static double listViewContainerSize = screehHeight / 9.32;

  //FoodPageInfo
  static double PageInfoImgSize = screehHeight / 2.66; //  2.278 / 1.952 -> 350
  static double bottomNavigationInfoPage = screehHeight / 7.76;
}
