import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.width,
    required this.height,
    required this.radius,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color.fromRGBO(121, 168, 212, 1),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(121, 168, 212, 0.2),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0),
              blurRadius: 0,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: 'Inter-regular',
            ),
          ),
        ),
      ),
    );
  }
}
