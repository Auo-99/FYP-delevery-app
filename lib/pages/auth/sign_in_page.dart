import 'package:delevery_app/pages/auth/sign_up_page.dart';
import 'package:delevery_app/routes/rout_helper.dart';
import 'package:delevery_app/widget/account_widget.dart';
import 'package:delevery_app/widget/app_icon.dart';
import 'package:delevery_app/widget/custom_loader.dart';
import 'package:delevery_app/widget/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_costum_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimension.dart';
import '../../widget/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController ){
      var phone = phoneController.text.trim();
      var password = passwordController.text.trim();

      if(phone.isEmpty) {
        showCostumSnackBar(
            "Type in email address", title: "Email address must not be empty");
      }else if(password.isEmpty){
        showCostumSnackBar("Type in your password address", title: "Password must not be empty");
      }else if(password.length<6){
        showCostumSnackBar("Password should be 6 character of more", title: "Password length");
      }else{
        authController.login(phone, password).then((status) {
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCostumSnackBar(status.message, color: Colors.redAccent);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimention.screehHeight*0.08),
              //Logo
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/image/logo1.png"),
                  radius: 100,
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(height: Dimention.heigt20*2,),
              //Welcome Text
              Row(
                children: [
                  Container(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimention.width20,
                        top: Dimention.heigt20,
                        bottom: Dimention.heigt20),
                    child: Text(
                      "Welcome ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimention.font20*2,
                        color: Colors.grey[700],

                      ),
                    ),
                  ),
                ],
              ),
              //Email field
              TextFieldWidget(
                textController: phoneController,
                hintText: "Phone Number ",
                prefix: Icons.phone,),
              SizedBox(height: Dimention.heigt20,),
              //Password Field
              TextFieldWidget(
                  textController: passwordController,
                  isObscure: true,
                  hintText: "Password",
                  prefix: Icons.password_sharp),
              SizedBox(height: Dimention.heigt20*4,),
              RichText(
                  text: TextSpan(
                    text: "Sign into your Account",
                    style: TextStyle(
                      color: Colors.grey[500],

                    ),
                  )
              ),
              SizedBox(height: Dimention.heigt10,),
              //Sign in Button
              GestureDetector(
                onTap: (){
                  _login(authController);
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
              SizedBox(height: Dimention.heigt30*5,),
              //Don't have an account textSpan
              RichText(
                text: TextSpan(
                    text: "Don\'t have an account ?",
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(SignUpPage(), transition: Transition.fade),
                        text: " Create",
                        style: TextStyle(
                            fontSize: Dimention.font16,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                ),
              ),

            ],
          ),
        ):CustomLoader();
      }),
    );
  }
}
