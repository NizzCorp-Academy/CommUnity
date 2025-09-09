import 'package:community_helpboard/features/core/app_text_styles.dart';
import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/feed_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelpPostsListView extends StatelessWidget {
  const HelpPostsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      buildWhen: (previous, current) =>
          current is HelpPostsLoaded ||
          current is HelpPostsLoading ||
          current is PostError,

      builder: (context, state) {
        if (state is HelpPostsLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is HelpPostsLoaded) {
          final posts = state.posts;
          if (posts.isEmpty) {
            return Center(
              child: Text("No posts found.", style: AppTextStyles.infoText),
            );
          } else {
            return ListView.separated(
              padding: EdgeInsets.only(top: 10, bottom: 10),

              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Align(
                  child: FeedPostCard(
                    userName: post.userName,
                    createdAt: post.createdAt,
                    title: post.title,
                    description: post.description,
                    chipColor: Color.fromRGBO(255, 229, 229, 1),
                    chipLabel: 'Help',
                    chipWidth: 43,
                    postId: post.id,
                    category: post.category,
                    communityId: post.communityId,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
