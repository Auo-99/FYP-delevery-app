import 'package:delevery_app/controllers/auth_controller.dart';
import 'package:delevery_app/controllers/cart_controller.dart';
import 'package:delevery_app/controllers/user_controller.dart';
import 'package:delevery_app/routes/rout_helper.dart';
import 'package:delevery_app/widget/account_widget.dart';
import 'package:delevery_app/widget/app_icon.dart';
import 'package:delevery_app/widget/custom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';
import '../../utils/dimension.dart';
import '../../widget/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BigText(
          text: "Profile",
          color: Colors.white,
          size: Dimention.font26,),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?
            (userController.isLoading?Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: Dimention.heigt20),
              child: Column(
                children: [
                  SizedBox(height: Dimention.heigt20,),
                  AppIconWidget(
                    icon: Icons.person,
                    size: Dimention.heigt30*5,
                    iconSize: Dimention.heigt15*5,
                    bgColor: AppColors.mainColor,
                    iconColor: Colors.white,
                  ),
                  SizedBox(height: Dimention.heigt30,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //name
                          AccountWidget(
                              bigText: BigText(text: userController.userModel!.name),
                              icon: AppIconWidget(icon: Icons.person,
                                iconColor: Colors.white,
                                bgColor: AppColors.mainColor,
                                iconSize: Dimention.font26,
                                size: Dimention.width10*5,
                              )),
                          SizedBox(height: Dimention.heigt20,),
                          //Phone Number
                          AccountWidget(
                              bigText: BigText(text: userController.userModel!.phone),
                              icon: AppIconWidget(icon: Icons.phone,
                                iconColor: Colors.white,
                                bgColor: AppColors.yellowColor,
                                iconSize: Dimention.font26,
                                size: Dimention.width10*5,
                              )),
                          SizedBox(height: Dimention.heigt20,),
                          //Email
                          AccountWidget(
                              bigText: BigText(text: userController.userModel!.email),
                              icon: AppIconWidget(icon: Icons.email,
                                iconColor: Colors.white,
                                bgColor: Colors.blue,
                                iconSize: Dimention.font26,
                                size: Dimention.width10*5,
                              )),
                          SizedBox(height: Dimention.heigt20,),
                          //location
                          AccountWidget(
                              bigText: BigText(text: "Add Your Location"),
                              icon: AppIconWidget(icon: Icons.location_on,
                                iconColor: Colors.white,
                                bgColor: Colors.green,
                                iconSize: Dimention.font26,
                                size: Dimention.width10*5,
                              )),
                          SizedBox(height: Dimention.heigt20,),
                          //message
                          AccountWidget(
                              bigText: BigText(text: "Message"),
                              icon: AppIconWidget(icon: Icons.message,
                                iconColor: Colors.white,
                                bgColor: Colors.blueAccent,
                                iconSize: Dimention.font26,
                                size: Dimention.width10*5,
                              )),
                          SizedBox(height: Dimention.heigt20,),
                          GestureDetector(
                            onTap: (){
                              if(Get.find<AuthController>().userLoggedIn()){
                                Get.find<AuthController>().clearSharedData();
                                Get.find<CartController>().clear();
                                Get.find<CartController>().clearCartHistory();
                                Get.toNamed(RouteHelper.getSignInPage());

                              }else{
                                print("You logged out!");
                              }
                            },
                            child: AccountWidget(
                                bigText: BigText(text: "Logout"),
                                icon: AppIconWidget(icon: Icons.logout,
                                  iconColor: Colors.white,
                                  bgColor: Colors.redAccent,
                                  iconSize: Dimention.font26,
                                  size: Dimention.width10*5,
                                )),
                          ),
                          SizedBox(height: Dimention.heigt20,),
                        ],
                      ),
                    ),
                  ),





                ],
              ),
            ):CustomLoader())
            :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimention.heigt20*9,
              margin: EdgeInsets.only(left:Dimention.width20, right:Dimention.width20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimention.width20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/image/signintocontinue.png"
                      )
                  )
              ),
            ),
            SizedBox(height: Dimention.heigt20,),
            GestureDetector(
              onTap: (){
                Get.offNamed(RouteHelper.getSignInPage());
              },
              child: Container(
                width: Dimention.screehWidth/2,
                height: Dimention.screehHeight/13,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimention.heigt15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(1, 1),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ]
                ),
                child: Center(child: BigText(text: "Sing In", color: Colors.white, size: Dimention.font26,)),
              ),
            ),
          ],
        );
      })
    );
  }
}
