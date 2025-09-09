import 'package:community_helpboard/features/admin/presentation/widgets/remove_button.dart';
import 'package:community_helpboard/features/core/app_assets.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final String name;
  void Function()? onTap;
  MemberCard({super.key, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.97,
      height: screenHeight * 0.1,

      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.primaryColor,
        boxShadow: AppShadows.primary,
        border: Border.all(width: 1, color: Color.fromRGBO(229, 229, 229, 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AppAssets.defaultProfileImage, width: 40, height: 40),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                ),

                Row(
                  children: [
                    Text(
                      'Member  ',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontSize: 14),
                    ),
                    Text(
                      '•',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          RemoveButton(onTap: onTap),
        ],
      ),
    );
  }
}
