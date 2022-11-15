import 'package:delevery_app/controllers/cart_controller.dart';
import 'package:delevery_app/controllers/popular_product_controller.dart';
import 'package:delevery_app/routes/rout_helper.dart';
import 'package:delevery_app/utils/app_constants.dart';
import 'package:delevery_app/utils/colors.dart';
import 'package:delevery_app/utils/dimension.dart';
import 'package:delevery_app/widget/app_icon.dart';
import 'package:delevery_app/widget/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widget/app_column.dart';
import '../../widget/expandabe_text_widget.dart';
import '../cart/cart_page.dart';


class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //index for the list
    var product = Get.find<PopularProductController>().popularProductList[pageId];

    //to use initProduct Function every time build this page
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: Dimention.PageInfoImgSize,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOADE_URI +
                          product.img),
                    ),
                  ),
                )),
            Positioned(
                left: Dimention.width20,
                right: Dimention.width20,
                top: Dimention.heigt45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                       if(page=="cartPage"){
                         Get.toNamed(RouteHelper.getCartPage());
                       }else{
                         Get.toNamed(RouteHelper.getInitial());
                       }
                      },
                      child: AppIconWidget(icon: Icons.arrow_back_ios),
                    ),

                    GetBuilder<PopularProductController>(builder: (controller){
                      return GestureDetector(
                        onTap: (){
                          if(controller.totalItems>=1)
                          Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: Stack(
                          children: [
                            AppIconWidget(icon: Icons.shopping_cart_outlined),
                            controller.totalItems>=1?
                                Positioned(
                                    top : 0,
                                    right: 0,
                                    child: Container(
                                      child: AppIconWidget(icon: Icons.circle, iconColor: Colors.transparent, bgColor: AppColors.mainColor, size: 20,),
                                )):
                                Container(),
                            Get.find<PopularProductController>().totalItems>=1?
                                Positioned(
                                  right: 4,
                                    top: 3,
                                    child: BigText(
                                      text: Get.find<PopularProductController>().totalItems.toString(),
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                ):Container(),
                          ]
                        ),
                      );
                    })
                  ],
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimention.PageInfoImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimention.width20,
                    right: Dimention.width20,
                    top: Dimention.heigt20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimention.heigt20),
                      topLeft: Radius.circular(Dimention.heigt20),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: product.name,
                    ),
                    SizedBox(
                      height: Dimention.heigt20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimention.heigt20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(
                          text: product.description,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (popularProduct) {
          return Container(
            height: Dimention.bottomNavigationInfoPage,
            width: double.maxFinite,
            padding: EdgeInsets.only(
                top: Dimention.heigt30,
                bottom: Dimention.heigt30,
                left: Dimention.width20,
                right: Dimention.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimention.heigt20),
                  topLeft: Radius.circular(Dimention.heigt20),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(Dimention.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimention.width20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                            // print(popularProduct.quantity);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          )),
                      SizedBox(
                        width: Dimention.width10 / 2,
                      ),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(
                        width: Dimention.width10 / 2,
                      ),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                            // print(popularProduct.quantity);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          )),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimention.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimention.width20),
                        color: AppColors.mainColor),
                    child: BigText(
                      text: "\$${product.price} Add to cart",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
