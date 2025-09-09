import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/my_community_card.dart';
import 'package:community_helpboard/features/core/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyCommunitiesList extends StatelessWidget {
  final String userId;
  const MyCommunitiesList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      buildWhen: (previous, current) {
        return current is MyCommunitiesLoaded ||
            current is MyCommunitiesLoading ||
            current is CommunityError;
      },
      builder: (context, state) {
        if (state is MyCommunitiesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MyCommunitiesLoaded) {
          if (state.communities.isEmpty) {
            return Center(
              child: Text(
                "No communities found.",
                style: AppTextStyles.infoText,
              ),
            );
          } else {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.communities.length,
              itemBuilder: (context, index) {
                final community = state.communities[index];
                return MyCommunityCard(
                  communityId: community.id,
                  communityName: community.name,
                  memberCount: community.members.length,
                  adminId: community.admin,
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 5),
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
