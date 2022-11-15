import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color? color ;
  double? size;
  double? height;
  SmallText({
    Key? key,
    required this.text,
    this.size  = 12,
    this.color = const Color(0xFFccc7c5),
    this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: "Roboto",
        fontSize: size,
        height: height,
      ),
    );
  }
}
