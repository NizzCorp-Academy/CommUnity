import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static final TextStyle headlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter-SemiBold',
    color: AppColors.textPrimary,
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle bodySmall = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter-Regular',
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle bodyMedium = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    fontFamily: 'Inter-Regular',
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle headlineLarge = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    fontFamily: 'Inter-Bold',
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontFamily: 'Inter-Medium',
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle infoText = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter-Regular',
    fontStyle: FontStyle.italic,
    overflow: TextOverflow.ellipsis,
  );
}
