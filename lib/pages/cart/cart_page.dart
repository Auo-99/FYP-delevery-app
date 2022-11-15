import 'package:delevery_app/widget/app_icon.dart';
import 'package:delevery_app/widget/big_text.dart';
import 'package:delevery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/rout_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimension.dart';
import '../Home/home_page_body.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimention.heigt30,
            left: Dimention.width20,
            right: Dimention.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIconWidget(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  bgColor: AppColors.mainColor,
                  iconSize: Dimention.icon24,
                ),
                SizedBox(
                  width: Dimention.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIconWidget(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    bgColor: AppColors.mainColor,
                    iconSize: Dimention.icon24,
                  ),
                ),
                AppIconWidget(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  bgColor: AppColors.mainColor,
                  iconSize: Dimention.icon24,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimention.heigt20 * 4,
            left: Dimention.width20,
            right: Dimention.width20,
            bottom: 0,
            child: Container(
              //color: Colors.blue,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController) {
                  var _cartItems = cartController.getItems;
                  return ListView.builder(
                      itemCount: _cartItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.maxFinite,
                          height: Dimention.heigt20 * 5,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cartItems[index].product!);
                                  if (popularIndex >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFood(
                                        popularIndex, 'cartPage'));
                                  } else {
                                    var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(
                                                _cartItems[index].product!);
                                    Get.toNamed(RouteHelper.getRecommendedFood(
                                        recommendedIndex, "cartPage"));
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: Dimention.heigt10),
                                  height: Dimention.heigt20 * 5,
                                  width: Dimention.width20 * 5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimention.width20),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(AppConstants
                                              .BASE_URL +
                                          AppConstants.UPLOADE_URI +
                                          cartController.getItems[index].img!),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimention.width15,
                              ),
                              Expanded(
                                  child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BigText(
                                        text: _cartItems[index].name.toString(),
                                        color: Colors.black54),
                                    SmallText(text: "Spicy"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text: "\$${_cartItems[index].price}",
                                          color: Colors.red,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: Dimention.heigt10,
                                              bottom: Dimention.heigt10,
                                              left: Dimention.width10,
                                              right: Dimention.width10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                Dimention.width20),
                                          ),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    cartController.addItem(
                                                        _cartItems[index]
                                                            .product!,
                                                        -1);
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: AppColors.signColor,
                                                  )),
                                              SizedBox(
                                                width: Dimention.width10 / 2,
                                              ),
                                              BigText(
                                                  text: _cartItems[index]
                                                      .quantity
                                                      .toString()),
                                              SizedBox(
                                                width: Dimention.width10 / 2,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    cartController.addItem(
                                                        _cartItems[index]
                                                            .product!,
                                                        1);
                                                  },
                                                  child: Icon(Icons.add,
                                                      color:
                                                          AppColors.signColor)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        );
                      });
                }),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
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
                      SizedBox(
                        width: Dimention.width10 / 2,
                      ),
                      BigText(text: "\$ ${cartController.getAmount}"),
                      SizedBox(
                        width: Dimention.width10 / 2,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimention.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimention.width20),
                      color: AppColors.mainColor),
                  child: BigText(
                    text: "Check Out",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
