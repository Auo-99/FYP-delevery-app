import 'package:delevery_app/utils/colors.dart';
import 'package:delevery_app/utils/dimension.dart';
import 'package:delevery_app/widget/big_text.dart';
import 'package:delevery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page_slider.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    //print("The height of the screen is :: " + MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: Dimention.heigt45, bottom: Dimention.heigt15),
            padding: EdgeInsets.only(
                left: Dimention.width20, right: Dimention.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: "Libya~",
                      color: AppColors.mainColor,
                    ),
                    Row(
                      children: [
                        SmallText(text: "tripoli"),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: Dimention.width45,
                  height: Dimention.heigt45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimention.heigt15),
                    color: AppColors.mainColor,
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: SingleChildScrollView(child: HomePageSlider())),
        ],
      ),
    );
  }
}
