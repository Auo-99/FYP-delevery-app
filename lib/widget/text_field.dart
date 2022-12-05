import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData prefix;
  bool isObscure;
  TextFieldWidget({Key? key,
    required this.textController,
    required this.hintText,
    required this.prefix,
    this.isObscure=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimention.width20, right: Dimention.width20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimention.heigt15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(1, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ]
      ),
      child: TextField(
        obscureText: isObscure,
        controller: textController,
        decoration:  InputDecoration(
          //hintText
          hintText: hintText,
          //prefixIcon
          prefixIcon: Icon(prefix, color: AppColors.yellowColor,),
          //focusedBorder
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimention.heigt15),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          //enabledBorder
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimention.heigt15),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          //border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimention.heigt15),
          ),
        ),
      ),
    );
  }
}
