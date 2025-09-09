import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/core/app_text_styles.dart';
import 'package:community_helpboard/features/profile/presentation/widgets/profile_community_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCommunityList extends StatelessWidget {
  const ProfileCommunityList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<CommunityBloc, CommunityState>(
      buildWhen: (previous, current) =>
          current is MyCommunitiesLoaded ||
          current is MyCommunitiesLoading ||
          current is CommunityError,
      builder: (context, state) {
        if (state is MyCommunitiesLoading) {
          return SizedBox(
            height: screenHeight * 0.246,

            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is MyCommunitiesLoaded) {
          if (state.communities.isEmpty) {
            return SizedBox(
              height: screenHeight * 0.246,
              child: Center(
                child: Text(
                  'No communities available.',
                  style: AppTextStyles.infoText,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.communities.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,

              itemBuilder: (context, index) {
                final communitiy = state.communities[index];
                return Align(
                  child: ProfileCommunityCard(
                    cardWidth: screenWidth * 0.92,
                    cardHeight: screenHeight * 0.094,
                    communityName: communitiy.name,
                    memberCountLabel: '${communitiy.members.length} members',
                  ),
                );
              },
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
