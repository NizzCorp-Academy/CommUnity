import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/community_join_card.dart';
import 'package:community_helpboard/features/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCommunitiesList extends StatelessWidget {
  final String userId;
  final bool isLoading;
  const AllCommunitiesList({
    super.key,
    required this.userId,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<CommunityBloc, CommunityState>(
      buildWhen: (previous, current) =>
          current is CommunityLoading ||
          current is CommunityLoaded ||
          current is CommunitySearchLoading ||
          current is CommunitySearchResult ||
          current is CommunityError,

      builder: (context, state) {
        if (state is CommunityLoading || state is CommunitySearchLoading) {
          return SizedBox(
            height: screenHeight * 0.246,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is CommunityLoaded) {
          if (state.communities.isEmpty) {
            return SizedBox(
              height: screenHeight * 0.246,
              child: Center(
                child: Text(
                  "No communities found.",
                  style: AppTextStyles.infoText,
                ),
              ),
            );
          } else {
            return ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return SizedBox(height: 7);
              },
              itemBuilder: (context, index) {
                final community = state.communities[index];
                return CommunityJoinCard(
                  name: community.name,
                  description: community.description,
                  onTap: isLoading
                      ? null
                      : () {
                          context.read<CommunityBloc>().add(
                            JoinCommunity(
                              communityId: community.id,
                              userId: userId,
                            ),
                          );
                        },
                  memberCount: community.members.length,
                );
              },
              itemCount: state.communities.length,
            );
          }
        } else if (state is CommunitySearchResult) {
          if (state.communities.isEmpty) {
            return SizedBox(
              height: screenHeight * 0.246,
              child: Center(
                child: Text(
                  "No communities found.",
                  style: AppTextStyles.infoText,
                ),
              ),
            );
          } else {
            return ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return SizedBox(height: 7);
              },
              itemBuilder: (context, index) {
                final community = state.communities[index];
                return CommunityJoinCard(
                  name: community.name,
                  description: community.description,
                  onTap: isLoading
                      ? null
                      : () {
                          context.read<CommunityBloc>().add(
                            JoinCommunity(
                              communityId: community.id,
                              userId: userId,
                            ),
                          );
                        },
                  memberCount: community.members.length,
                );
              },
              itemCount: state.communities.length,
            );
          }
        }

        return SizedBox();
      },
    );
  }
}
