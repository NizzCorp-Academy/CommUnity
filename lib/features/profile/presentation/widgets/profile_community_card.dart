import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:flutter/material.dart';

class ProfileCommunityCard extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final String communityName;
  final String memberCountLabel;

  const ProfileCommunityCard({
    super.key,
    required this.cardWidth,
    required this.cardHeight,
    required this.communityName,
    required this.memberCountLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: AppShadows.primary,
      ),
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    communityName,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                  
                ),
                const SizedBox(height: 3),
                Text(
                  memberCountLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: AppColors.tertiaryColor,
          ),
        ],
      ),
    );
  }
}
