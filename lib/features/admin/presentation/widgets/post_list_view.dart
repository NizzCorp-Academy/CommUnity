import 'package:community_helpboard/features/admin/presentation/widgets/post_card.dart';
import 'package:community_helpboard/features/core/app_snack_bar.dart';
import 'package:community_helpboard/features/core/app_text_styles.dart';
import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';
import 'package:community_helpboard/features/posts/presentation/utils/time_ago.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListView extends StatelessWidget {
  final String communityId;
  const PostListView({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      buildWhen: (previous, current) =>
          current is PostLoading ||
          current is PostLoaded ||
          current is PostError ||
          current is DeletePostLoading,

      listenWhen: (previous, current) =>
          current is PostError || current is DeletePostSuccess,

      listener: (context, state) {
        if (state is DeletePostSuccess) {
          AppSnackBar.show(context, state.message);
          context.read<PostBloc>().add(LoadAllPosts(communityId));
        }
      },
      builder: (BuildContext context, PostState state) {
        bool isLoading = state is DeletePostLoading;

        if (state is PostLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PostLoaded) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text("No posts available.", style: AppTextStyles.infoText),
            );
          } else {
            return ListView.separated(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Align(
                  child: PostCard(
                    title: post.title,
                    description: post.description,
                    hoursAgo: getTimeAgo(post.createdAt.toDate()),
                    chipLabel: (post.category == 'lost_and_found'
                        ? 'Lost & Found'
                        : post.category == 'help'
                        ? 'Help'
                        : post.category == 'announcements'
                        ? 'Announcement'
                        : ''),
                    chipColor: (post.category == 'lost_and_found'
                        ? Color.fromRGBO(254, 249, 195, 1)
                        : post.category == 'help'
                        ? Color.fromRGBO(255, 229, 229, 1)
                        : post.category == 'announcements'
                        ? Color.fromRGBO(229, 240, 255, 1)
                        : Colors.black),
                    chipWidth: (post.category == 'lost_and_found'
                        ? 91
                        : post.category == 'help'
                        ? 43
                        : post.category == 'announcements'
                        ? 104
                        : 0),
                    onTap: isLoading
                        ? null
                        : () {
                            context.read<PostBloc>().add(
                              DeletePostRequested(
                                communityId: post.communityId,
                                category: post.category,
                                postId: post.id,
                              ),
                            );
                          },
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: state.posts.length,
            );
          }
        }

        return SizedBox();
      },
    );
  }
}
