import 'package:community_helpboard/features/core/app_assets.dart';

import 'package:community_helpboard/features/profile/application/bloc/profile_bloc.dart';
import 'package:community_helpboard/features/profile/presentation/widgets/profile_stat_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileStatsList extends StatelessWidget {
  const ProfileStatsList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          current is ProfileLoading ||
          current is ProfileLoaded ||
          current is ProfileFailure,
      builder: (context, state) {
        if (state is ProfileLoading) {
          return CircularProgressIndicator();
        }
        if (state is ProfileLoaded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileStatCard(
                cardWidth: screenWidth * 0.429,
                cardHeight: screenHeight * 0.099,
                statValue: state.profile.postCount.toString(),
                statLabel: 'Posts',
                iconAsset: AppAssets.postLogo,
              ),

              SizedBox(width: 15),
              ProfileStatCard(
                cardWidth: screenWidth * 0.429,
                cardHeight: screenHeight * 0.099,
                statValue: state.profile.commentCount.toString(),
                statLabel: 'Comments',
                iconAsset: AppAssets.commentLogo,
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
