import 'package:delevery_app/widget/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimension.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIconWidget icon;
  BigText bigText;
  AccountWidget({Key? key, required this.bigText, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding : EdgeInsets.only(top: Dimention.heigt10, left: Dimention.width20, bottom: Dimention.heigt10,),
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
      child: Row(
        children: [
          icon,
          SizedBox(width: Dimention.width20,),
          bigText,
        ],
      ),
    );
  }
}
