import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';
import 'package:community_helpboard/features/posts/infrastructure/repositories/post_repository_impl.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/community_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelpPostList extends StatelessWidget {
  const HelpPostList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PostBloc(PostRepositoryImpl())
            ..add(GetAllPostsEvent('hnq36Nn11cIV7nHdT240', 'help')),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              final posts = state.posts;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CommunityPostCard(
                      title: post.title,
                      description: post.description,
                      color: Color.fromRGBO(255, 229, 229, 1),
                      text: 'Help',
                      width: 43,
                    ),
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
