import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileStatCard extends StatelessWidget {
  const ProfileStatCard({
    super.key,
    required this.cardWidth,
    required this.cardHeight,
    required this.statValue,
    required this.statLabel,
    required this.iconAsset,
  });

  final double cardWidth;
  final double cardHeight;
  final String statValue;
  final String statLabel;
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryColor,
        boxShadow: AppShadows.primary,
      ),
      child: Row(
        children: [
          SizedBox(width: 15),
          SvgPicture.asset(iconAsset, width: 40, height: 40),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  statValue,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 5),
                Text(
                  statLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
