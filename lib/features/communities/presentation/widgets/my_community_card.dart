import 'package:community_helpboard/features/core/app_assets.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:community_helpboard/features/posts/presentation/screens/post_screen.dart';

import 'package:flutter/material.dart';

class MyCommunityCard extends StatelessWidget {
  final String communityId;
  final String communityName;
  final int memberCount;
  final String adminId;

  const MyCommunityCard({
    super.key,
    required this.communityId,
    required this.communityName,
    required this.memberCount,
    required this.adminId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(communityId: communityId),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: screenWidth * 0.400,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: AppColors.primaryColor,
          boxShadow: AppShadows.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppAssets.communityDefault,
              fit: BoxFit.fill,
              height: screenHeight * 0.098,
              width: double.infinity,
            ),
            SizedBox(
              width: screenWidth * 0.373,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      communityName,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 14),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$memberCount members',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
