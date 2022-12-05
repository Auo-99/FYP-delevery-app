import 'package:delevery_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("Loading State ${Get.find<AuthController>().isLoading}");
    return Center(
      child: Container(
        width: Dimention.width20*5,
        height: Dimention.heigt20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimention.heigt20*5/2),
          color: AppColors.mainColor,
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
