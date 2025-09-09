import 'package:community_helpboard/features/admin/presentation/screens/admin_panel_screen.dart';
import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/core/app_colors.dart';

import 'package:community_helpboard/features/core/app_snack_bar.dart';
import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';

import 'package:community_helpboard/features/posts/presentation/screens/create_post_screen.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/announcement_posts_list_view.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/help_posts_list_view.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/lost_and_found_post_list_view.dart';
import 'package:community_helpboard/features/widgets/primary_action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  final String communityId;

  const PostScreen({super.key, required this.communityId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool isThisUserIsAdmin = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    context.read<CommunityBloc>().add(
      CheckAdminStatus(userId: userId, communityId: widget.communityId),
    );

    context.read<PostBloc>().add(LoadHelpPosts(widget.communityId));
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final index = _tabController.index;
      switch (index) {
        case 0:
          context.read<PostBloc>().add(LoadHelpPosts(widget.communityId));
          break;
        case 1:
          context.read<PostBloc>().add(
            LoadAnnouncementPosts(widget.communityId),
          );
          break;
        case 2:
          context.read<PostBloc>().add(
            LoadLostAndFoundPosts(widget.communityId),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostError) {
          AppSnackBar.show(context, state.message);
        }
      },
      child: BlocListener<CommunityBloc, CommunityState>(
        listenWhen: (previous, current) => current is PostError,
        listener: (context, state) {},
        child: BlocBuilder<CommunityBloc, CommunityState>(
          buildWhen: (previous, current) => current is AdminIdentified,

          builder: (context, state) {
            if (state is AdminIdentified) {
              isThisUserIsAdmin = state.isAdmin;
              state.isAdmin = false;
            }
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 90,
                backgroundColor: Colors.transparent,

                actions: [
                  isThisUserIsAdmin
                      ? PrimaryActionButton(
                          buttonWidth: 70,
                          buttonHeight: 30,
                          borderRadius: 7,
                          label: 'Admin',
                          labelWeight: FontWeight.w600,
                          labelSize: 12,
                          onPressed: () {
                            context.read<PostBloc>().add(
                              LoadAllPosts(widget.communityId),
                            );
                            context.read<CommunityBloc>().add(
                              LoadCommunityMembers(widget.communityId),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminPanelScreen(
                                  communityId: widget.communityId,
                                ),
                              ),
                            );
                          },
                          fontFamily: 'Inter-SemiBold',
                        )
                      : SizedBox(),

                  SizedBox(width: 5),
                ],

                title: Text(
                  'Community Posts',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(fontSize: 20),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  dividerColor: Color.fromRGBO(243, 244, 246, 1),
                  dividerHeight: 1,
                  indicatorColor: AppColors.tertiaryColor,
                  labelColor: AppColors.tertiaryColor,
                  unselectedLabelColor: AppColors.textPrimary,
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontSize: 16),
                  unselectedLabelStyle: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontSize: 16),
                  indicatorWeight: 2,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(child: Text('Help')),
                    Tab(child: Text('Announcements')),
                    Tab(child: Text('Lost & Found')),
                  ],
                ),
              ),

              body: TabBarView(
                controller: _tabController,
                children: [
                  HelpPostsListView(),
                  AnnouncementPostsListView(),
                  LostAndFoundPostListView(),
                ],
              ),

              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(999)),
                ),
                backgroundColor: AppColors.tertiaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CreatePostScreen(communityId: widget.communityId),
                    ),
                  );
                },
                child: Icon(Icons.add, color: AppColors.primaryColor),
              ),
            );
          },
        ),
      ),
    );
  }
}
