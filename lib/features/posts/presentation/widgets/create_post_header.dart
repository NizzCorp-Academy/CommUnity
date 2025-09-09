import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:flutter/material.dart';

class CreatePostHeader extends StatelessWidget {
  const CreatePostHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double totalTopHeight =
        kToolbarHeight + MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      height: totalTopHeight + 30,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(238, 238, 238, 1), width: 1),
        ),
      ),
      padding: EdgeInsets.all(15),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 16,
                  color: AppColors.tertiaryColor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Create Post',

              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
