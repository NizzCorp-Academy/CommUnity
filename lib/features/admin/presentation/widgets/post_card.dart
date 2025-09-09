import 'package:community_helpboard/features/admin/presentation/widgets/delete_button.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:community_helpboard/features/widgets/category_chip.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String description;
  final String hoursAgo;
  final String chipLabel;
  final Color chipColor;
  final double chipWidth;
  void Function()? onTap;

  PostCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.description,
    required this.hoursAgo,
    required this.chipLabel,
    required this.chipColor,
    required this.chipWidth,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(right: 20, left: 16, bottom: 16, top: 16),
      width: screenWidth * 0.955,
      height: screenHeight * 0.250,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: AppShadows.primary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CategoryChip(width: chipWidth, color: chipColor, text: chipLabel),
              SizedBox(width: 7),
              Text(
                hoursAgo,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Color.fromRGBO(107, 114, 128, 1),
                ),
              ),
            ],
          ),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontSize: 16),
          ),
          Text(
            maxLines: 2,
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Color.fromRGBO(75, 85, 99, 1),
            ),
          ),

          Center(child: DeleteButton(onTap: onTap)),
        ],
      ),
    );
  }
}
