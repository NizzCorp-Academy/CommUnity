import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final double width;
  final Color color;
  final String text;

  const CategoryChip({
    super.key,
    required this.width,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(999)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 12,
            fontFamily: 'Inter-SemiBold',
          ),
        ),
      ),
    );
  }
}
