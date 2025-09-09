import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';
import 'package:community_helpboard/features/posts/presentation/utils/time_ago.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/comment_sheet.dart';
import 'package:community_helpboard/features/widgets/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPostCard extends StatelessWidget {
  final String postId;
  final String category;
  final String communityId;
  final String title;
  final String description;
  final String chipLabel;
  final Color chipColor;
  final double chipWidth;
  final String userName;
  final Timestamp createdAt;
  const FeedPostCard({
    super.key,
    required this.title,
    required this.createdAt,
    required this.description,
    required this.chipLabel,
    required this.chipColor,
    required this.chipWidth,
    required this.userName,
    required this.postId,
    required this.category,
    required this.communityId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.970,
      height: screenHeight * 0.217,
      padding: EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.primaryColor,
        boxShadow: AppShadows.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CategoryChip(width: chipWidth, color: chipColor, text: chipLabel),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  maxLines: 1,
                  getTimeAgo(createdAt.toDate()),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Color.fromRGBO(107, 114, 128, 1),
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  textAlign: TextAlign.end,
                  userName.toLowerCase(),
                  style: TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),
          Text(
            maxLines: 1,
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              description,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
                color: Color.fromRGBO(75, 85, 99, 1),
              ),
            ),
          ),
          GestureDetector(
            child: Icon(Icons.comment, size: 20),
            onTap: () {
              context.read<PostBloc>().add(
                LoadComments(
                  postId: postId,
                  communityId: communityId,
                  category: category,
                ),
              );

              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CommentSheet(
                    postId: postId,
                    category: category,
                    communityId: communityId,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
