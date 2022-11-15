import 'package:delevery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';
import 'big_text.dart';
import 'icon_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimention.font26,
        ),
        SizedBox(
          height: Dimention.heigt15,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          height: Dimention.heigt15,
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
    );
  }
}
