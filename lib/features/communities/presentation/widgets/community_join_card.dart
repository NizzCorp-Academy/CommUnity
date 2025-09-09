import 'package:community_helpboard/features/core/app_assets.dart';
import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:community_helpboard/features/widgets/primary_action_button.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:flutter/material.dart';

class CommunityJoinCard extends StatelessWidget {
  final String name;
  final String description;
  final Function()? onTap;
  final int memberCount;

  const CommunityJoinCard({
    super.key,
    required this.name,
    required this.description,
    required this.onTap,
    required this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.954,
      height: screenHeight * 0.177,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: AppColors.primaryColor,
        boxShadow: AppShadows.primary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Image.asset(
              AppAssets.communityDefault,
              width: screenWidth * 0.213,
              height: screenHeight * 0.099,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  maxLines: 2,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 14),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Expanded(
                        child: Text(
                          '$memberCount members',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      PrimaryActionButton(
                        buttonWidth: 60,
                        buttonHeight: 36,
                        borderRadius: 8,
                        label: 'Join',
                        labelWeight: FontWeight.w500,
                        labelSize: 14,
                        onPressed: onTap,
                        fontFamily: 'Inter-Medium',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
