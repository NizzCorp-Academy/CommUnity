import 'package:flutter/material.dart';

class ProfileActionButton extends StatelessWidget {
  final double buttonWidth;
  final double buttonHeight;
  final double borderRadius;
  final String label;
  final FontWeight labelWeight;
  final double labelSize;
  final VoidCallback onPressed;
  final String fontFamily;
  final List<BoxShadow>? boxShadow;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;

  final Color? buttonColor;
  final Color? labelColor;
  final Color? borderColor;

  const ProfileActionButton({
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
    this.icon,
    this.iconColor,
    this.iconSize,
    this.buttonColor,
    this.labelColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 1)
              : null,
          boxShadow: boxShadow,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: iconSize),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: labelSize,
                  fontWeight: labelWeight,
                  fontFamily: fontFamily,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
