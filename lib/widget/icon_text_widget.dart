import 'package:delevery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';

class IconText extends StatelessWidget {
  String text;
  Color? color;
  IconData icon;
  IconText({Key? key, required this.text, required this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color,),
        SizedBox(width: 5,),
        SmallText(text: text),
      ],
    );
  }
}
