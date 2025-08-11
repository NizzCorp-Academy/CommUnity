import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconLabelChip extends StatelessWidget {
  final String text;
  final String icon;
  final Color color;
  final double width;
  const IconLabelChip({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(9999)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 5),
          Text(
            text,

            style: TextStyle(
              color: Color.fromRGBO(46, 46, 46, 1),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Inter-Regular',
            ),
          ),
        ],
      ),
    );
  }
}
