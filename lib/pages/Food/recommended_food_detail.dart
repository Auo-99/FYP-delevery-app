import 'package:delevery_app/controllers/popular_product_controller.dart';
import 'package:delevery_app/controllers/recommended_product_controller.dart';
import 'package:delevery_app/pages/cart/cart_page.dart';
import 'package:delevery_app/routes/rout_helper.dart';
import 'package:delevery_app/utils/app_constants.dart';
import 'package:delevery_app/widget/app_icon.dart';
import 'package:delevery_app/widget/big_text.dart';
import 'package:delevery_app/widget/expandabe_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimension.dart';


class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
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
                    child: AppIconWidget(
                      icon: Icons.clear,
                    )),
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      //don't route to cart page if you don't have item in the cart
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
                                child: GestureDetector(
                                  onTap: (){
                                    Get.to(()=>CartPage());
                                  },
                                    child: AppIconWidget(icon: Icons.circle, iconColor: Colors.transparent, bgColor: AppColors.mainColor, size: 20,)
                                ),
                              )):
                          Container(),
                          Get.find<PopularProductController>().totalItems>=1?
                          Positioned(
                            right: 3,
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
                }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: BigText(size: Dimention.font26, text: product.name)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimention.heigt20),
                        topRight: Radius.circular(Dimention.heigt20))),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOADE_URI + product.img,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                child: ExpandableTextWidget(text: product.description),
                margin: EdgeInsets.only(
                    left: Dimention.width20, right: Dimention.width20),
              ),
            ]),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimention.width20 * 2.5,
                right: Dimention.width20 * 2.5,
                top: Dimention.heigt10,
                bottom: Dimention.heigt10,
              ),

              //Add and Remove Button
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIconWidget(
                        iconColor: Colors.white,
                        bgColor: AppColors.mainColor,
                        icon: Icons.remove),
                  ),
                  BigText(
                    text: " \$${product.price} x " " ${controller.inCartItems} ",
                    color: AppColors.mainBlackColor,
                    size: Dimention.font26,
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIconWidget(
                        iconColor: Colors.white,
                        bgColor: AppColors.mainColor,
                        icon: Icons.add),
                  ),
                ],
              ),

            ),
            Container(
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
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimention.width20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimention.width20),
                          color: AppColors.mainColor),
                      child: BigText(
                        text: "\$${product.price} | Add to cart",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      })
    );
  }
}
