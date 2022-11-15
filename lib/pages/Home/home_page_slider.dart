import 'package:delevery_app/controllers/popular_product_controller.dart';
import 'package:delevery_app/controllers/recommended_product_controller.dart';
import 'package:delevery_app/models/products_model.dart';
import 'package:delevery_app/utils/dimension.dart';
import 'package:delevery_app/widget/big_text.dart';
import 'package:delevery_app/widget/icon_text_widget.dart';
import 'package:delevery_app/widget/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../routes/rout_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';


class HomePageSlider extends StatefulWidget {
  const HomePageSlider({Key? key}) : super(key: key);

  @override
  State<HomePageSlider> createState() => _HomePageSliderState();
}

class _HomePageSliderState extends State<HomePageSlider> {
  PageController pController = PageController(viewportFraction: 0.85);
  double _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimention.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pController.addListener(() {
      setState(() {
        _currPageValue = pController.page!;
        //print(_currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimention.pageView,
                  child: PageView.builder(
                      controller: pController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, index) {
                        return _buildPageItem(
                            index, popularProducts.popularProductList[index]);
                      }))
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        //dots part
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //Popular Text
        SizedBox(
          height: Dimention.heigt30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimention.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimention.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimention.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "food Paring"),
              ),
            ],
          ),
        ),

        //Recommended Food section
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimention.width20,
                            right: Dimention.width20,
                            bottom: Dimention.heigt10),
                        child: Row(
                          children: [
                            //Image section
                            Container(
                              width: Dimention.listViewImgSize,
                              height: Dimention.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimention.heigt20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    AppConstants.BASE_URL +
                                        AppConstants.UPLOADE_URI +
                                        recommendedProduct
                                            .recommendedProductList[index].img!,
                                  ),
                                ),
                              ),
                            ),
                            //Text section
                            Expanded(
                              child: Container(
                                height: Dimention.listViewContainerSize,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomRight:
                                          Radius.circular(Dimention.heigt20),
                                      topRight:
                                          Radius.circular(Dimention.heigt20),
                                    )),
                                padding: EdgeInsets.only(
                                  left: Dimention.width10,
                                  right: Dimention.width10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(
                                        text: recommendedProduct
                                            .recommendedProductList[index]
                                            .name!),
                                    SizedBox(
                                      height: Dimention.heigt10,
                                    ),
                                    SmallText(
                                        text: "With chinese characteristics"),
                                    SizedBox(
                                      height: Dimention.heigt10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconText(
                                          text: "normal",
                                          icon: Icons.circle,
                                          color: AppColors.mainColor,
                                        ),
                                        IconText(
                                          text: "1.7km",
                                          icon: Icons.location_on,
                                          color: AppColors.iconColor1,
                                        ),
                                        IconText(
                                          text: "32min",
                                          icon: Icons.watch_later_outlined,
                                          color: AppColors.iconColor2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(color: AppColors.mainColor);
        }),

        //Popular section
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var _currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var _currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1);
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var _currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1);
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimention.width10, right: Dimention.width10),
              height: Dimention.pageViewContainer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimention.heigt30),
                  image: DecorationImage(
                    image: NetworkImage(
                      AppConstants.BASE_URL +
                          AppConstants.UPLOADE_URI +
                          popularProduct.img!,
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimention.width30,
                  right: Dimention.width30,
                  bottom: Dimention.heigt30),
              padding: EdgeInsets.only(
                  left: Dimention.width15,
                  right: Dimention.width30,
                  top: Dimention.heigt15),
              height: Dimention.pageViewContainerText,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimention.heigt30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE8E8E8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: popularProduct.name!,
                  ),
                  SizedBox(
                    height: Dimention.heigt10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        children: List.generate(
                            5,
                            (index) => Icon(
                                  Icons.star,
                                  color: AppColors.mainColor,
                                  size: Dimention.icon15,
                                )),
                      ),
                      SizedBox(
                        width: Dimention.width10,
                      ),
                      SmallText(text: "4.5"),
                      SizedBox(
                        width: Dimention.width10,
                      ),
                      SmallText(text: "3 Comments"),
                    ],
                  ),
                  SizedBox(
                    height: Dimention.heigt10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconText(
                        text: "normal",
                        icon: Icons.circle,
                        color: AppColors.mainColor,
                      ),
                      IconText(
                        text: "1.7km",
                        icon: Icons.location_on,
                        color: AppColors.iconColor1,
                      ),
                      IconText(
                        text: "32min",
                        icon: Icons.watch_later_outlined,
                        color: AppColors.iconColor2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
