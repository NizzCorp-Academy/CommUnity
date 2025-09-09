import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/presentation/screens/create_community_screen.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/all_communities_list.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/communities_header.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/community_search_bar.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/my_communities_list.dart';
import 'package:community_helpboard/features/core/app_snack_bar.dart';
import 'package:community_helpboard/features/widgets/primary_action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityHomeScreen extends StatelessWidget {
  CommunityHomeScreen({super.key});
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<CommunityBloc, CommunityState>(
      listenWhen: (previous, current) =>
          current is CommunityError || current is JoinCommunitySuccess,

      buildWhen: (previous, current) =>
          current is JoinCommunityLoading || current is CommunityError,

      listener: (context, state) {
        if (state is CommunityError) {
          AppSnackBar.show(context, state.message);
        } else if (state is JoinCommunitySuccess) {
          AppSnackBar.show(context, state.message);
          context.read<CommunityBloc>().add(LoadMyCommunities(userId));
          context.read<CommunityBloc>().add(LoadAllCommunities(userId));
        }
      },
      builder: (context, state) {
        final bool isLoading = state is JoinCommunityLoading;
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CommunitiesHeader(userId: userId),
                SizedBox(height: 20),
                CommunitySearchBar(userId: userId),
                SizedBox(height: 35),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'My Communities',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: screenHeight * 0.202,
                  child: MyCommunitiesList(userId: userId),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'All Communities',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),

                AllCommunitiesList(userId: userId, isLoading: isLoading),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryActionButton(
              buttonWidth: 0.0,
              buttonHeight: screenHeight * 0.059,
              borderRadius: 12,
              label: 'Create Community',
              labelWeight: FontWeight.w600,
              labelSize: 16,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateCommunityScreen(userId: userId),
                  ),
                );
              },
              fontFamily: 'Inter-SemiBold',
            ),
          ),
        );
      },
    );
  }
}
