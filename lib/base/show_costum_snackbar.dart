import 'package:delevery_app/widget/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCostumSnackBar(String message, {bool isError = true, String title="Error", color=Colors.redAccent}){

  Get.snackbar(
    title,
    message,
    messageText: Text(
      message,
      style: TextStyle(
        color: Colors.white,

      ),),
    titleText: BigText(text: title, color: Colors.white,),
    colorText: Colors.white,
    backgroundColor: color,
    snackPosition: SnackPosition.TOP,
  );
}