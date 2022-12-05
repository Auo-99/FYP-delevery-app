import 'package:delevery_app/base/show_costum_snackbar.dart';
import 'package:delevery_app/controllers/auth_controller.dart';
import 'package:delevery_app/models/sign_up_model.dart';
import 'package:delevery_app/routes/rout_helper.dart';
import 'package:delevery_app/widget/big_text.dart';
import 'package:delevery_app/widget/custom_loader.dart';
import 'package:delevery_app/widget/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';
import '../../utils/dimension.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpOptions = [
      "t.png",
      "f.png",
      "g.png"
    ];
    void _registration(AuthController authController ){
      //var authController = Get.find<AuthController>();
      var name = nameController.text.trim();
      var email = emailController.text.trim();
      var password = passwordController.text.trim();
      var phone = phoneController.text.trim();

      if(email.isEmpty) {
        showCostumSnackBar("Type in email address", title: "Email address must not be empty");
      }else if(!GetUtils.isEmail(email)){
        showCostumSnackBar("Type in valid email address", title: "Invalid email address");
      }else if(name.isEmpty){
        showCostumSnackBar("Type in your name address", title: "name must not be empty");
      }else if(password.isEmpty){
        showCostumSnackBar("Type in your password address", title: "Password must not be empty");
      }else if(password.length<6){
        showCostumSnackBar("Password should be 6 character of more", title: "Password length");
      }else if(phone.isEmpty){
        showCostumSnackBar("Type in phone number address", title: "Phone number must not be empty");
      }else{
        //should not be heere just for debugging purposes
        showCostumSnackBar("successfully creating account", title: "successfully", color: Colors.greenAccent);
        //passing the user data to model
        SignUpModel signUpModel = SignUpModel(
            name: name,
            phone: phone,
            email: email,
            password: password);
          authController.registration(signUpModel).then((status) {
            if(status.isSuccess){
              Get.offNamed(RouteHelper.getInitial());
              print("Success Registration");
            }else{
              showCostumSnackBar(status.message, color: Colors.redAccent);
            }
          });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
          //physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimention.screehHeight*0.06,),
              //logo
              Center(
                child: Container(
                  height: Dimention.screehHeight*0.25,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100,
                    backgroundImage: AssetImage(
                      "assets/image/logo1.png",
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimention.heigt10,),
              //email
              TextFieldWidget(
                  textController: emailController,
                  hintText: "Email",
                  prefix: Icons.email),
              SizedBox(height: Dimention.heigt20,),
              //password
              TextFieldWidget(
                  isObscure: true,
                  textController: passwordController,
                  hintText: "Password",
                  prefix: Icons.password_sharp),
              SizedBox(height: Dimention.heigt20,),
              //name
              TextFieldWidget(
                  textController: nameController,
                  hintText: "Name",
                  prefix: Icons.person),
              SizedBox(height: Dimention.heigt20,),
              //phone
              TextFieldWidget(
                  textController: phoneController,
                  hintText: "Phone",
                  prefix: Icons.phone),
              SizedBox(height: Dimention.heigt30*2,),

              //Sign UP Button
              GestureDetector(
                onTap: (){
                  _registration(_authController);
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
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          spreadRadius: 1,
                        ),
                      ]
                  ),
                  child: Center(child:
                  BigText(
                    text: "Sign Up",
                    size: Dimention.font26,
                    color: Colors.white,)),
                ),
              ),
              SizedBox(height: Dimention.heigt10,),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Have An Account ?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimention.font16
                      )
                  )
              ),

              SizedBox(height: Dimention.screehHeight*0.05,),
              //Sign Up options
              RichText(
                text: TextSpan(
                  text: "Sign Up Using ",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimention.font16,
                  ),
                ),
              ),
              SizedBox(height: Dimention.heigt10,),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: Dimention.heigt15+Dimention.heigt10,
                    backgroundImage: AssetImage("assets/image/"+signUpOptions[index]),
                  ),
                )),
              ),

            ],
          ),
        ):const CustomLoader();
      })
    );
  }
}
