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
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize:12)
        ),
      ),
    );
  }
}
