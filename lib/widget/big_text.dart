import 'package:delevery_app/utils/dimension.dart';
import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color? color;
  double size;
  TextOverflow overFlow;

  BigText({
    Key? key,
    required this.text,
    this.size = 0,
    this.color = const Color(0xFF332d2b),
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: "Roboto",
        fontSize: size==0?Dimention.font20:size,
        fontWeight: FontWeight.w400,
        overflow: overFlow,
      ),
    );
  }
}
