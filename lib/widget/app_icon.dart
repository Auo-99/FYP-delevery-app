import 'package:delevery_app/utils/dimension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  IconData icon;
  Color iconColor;
  Color bgColor;
  double size;
  double iconSize;

  AppIconWidget({
    Key? key,
    required this.icon,
    this.iconColor = const Color(0xFF756d54),
    this.bgColor = const Color(0xFFfcf4e4),
    this.size = 40,
    this.iconSize = 16
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(size / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(1, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ]
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
