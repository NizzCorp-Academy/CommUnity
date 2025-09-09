import 'package:community_helpboard/features/admin/presentation/widgets/member_card.dart';
import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/core/app_snack_bar.dart';
import 'package:community_helpboard/features/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberListView extends StatelessWidget {
  final String communityId;
  const MemberListView({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityBloc, CommunityState>(
      listenWhen: (previous, current) =>
          current is CommunityError || current is DeleteMemberSuccess,
      buildWhen: (previous, current) =>
          current is MemberLoading ||
          current is MemberLoaded ||
          current is CommunityError,
      listener: (context, state) {
        if (state is DeleteMemberSuccess) {
          AppSnackBar.show(context, state.message);
          context.read<CommunityBloc>().add(LoadCommunityMembers(communityId));
        }
      },
      builder: (BuildContext context, CommunityState state) {
        bool isLoading = state is DeleteMemberLoading;
        if (state is MemberLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MemberLoaded) {
          if (state.members.isEmpty) {
            return Center(
              child: Text('No members yet.', style: AppTextStyles.infoText),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              itemCount: state.members.length,
              itemBuilder: (context, index) {
                final member = state.members[index];
                return Align(
                  child: MemberCard(
                    name: member.name,
                    onTap: isLoading
                        ? null
                        : () {
                            context.read<CommunityBloc>().add(
                              DeleteMemberRequested(
                                userId: member.id,
                                communityId: communityId,
                              ),
                            );
                          },
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
