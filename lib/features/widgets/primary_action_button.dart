import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  final double buttonWidth;
  final double buttonHeight;
  final double borderRadius;
  final String label;
  final FontWeight labelWeight;
  final double labelSize;
  final VoidCallback? onPressed;
  final String fontFamily;
  final List<BoxShadow>? boxShadow;
  const PrimaryActionButton({
    super.key,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.borderRadius,
    required this.label,
    required this.labelWeight,
    required this.labelSize,
    required this.onPressed,
    required this.fontFamily,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,

        decoration: BoxDecoration(
          color: AppColors.tertiaryColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: boxShadow,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: labelSize,
              fontWeight: labelWeight,
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
