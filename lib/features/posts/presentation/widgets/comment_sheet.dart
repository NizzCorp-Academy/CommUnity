import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/core/app_snack_bar.dart';

import 'package:community_helpboard/features/core/app_text_styles.dart';
import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentSheet extends StatefulWidget {
  final String postId;
  final String category;
  final String communityId;

  const CommentSheet({
    super.key,
    required this.postId,
    required this.category,
    required this.communityId,
  });

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<PostBloc, PostState>(
      listenWhen: (previous, current) => current is CommentSuccess,
      listener: (context, state) {
        if (state is CommentSuccess) {
          AppSnackBar.show(context, state.message);
          context.read<PostBloc>().add(
            LoadComments(
              postId: widget.postId,
              communityId: widget.communityId,
              category: widget.category,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        width: screenWidth,
        height: screenHeight * 0.7,

        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Comment cannot be empty';
                        }
                        return null;
                      },
                      controller: _commentController,
                      decoration: InputDecoration(hintText: 'Write a comment'),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<PostBloc>().add(
                          AddCommentRequested(
                            commentText: _commentController.text.trim(),
                            postId: widget.postId,
                            communityId: widget.communityId,
                            category: widget.category,
                          ),
                        );
                        _commentController.clear();
                      }
                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: BlocBuilder<PostBloc, PostState>(
                  buildWhen: (previous, current) =>
                      current is CommentsLoading ||
                      current is CommentsLoaded ||
                      current is PostError,
                  builder: (context, state) {
                    if (state is CommentsLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CommentsLoaded) {
                      if (state.comments.isEmpty) {
                        return Center(
                          child: Text(
                            'No comments available',
                            style: AppTextStyles.infoText,
                          ),
                        );
                      } else {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.comments.length,
                          itemBuilder: (context, index) {
                            final comment = state.comments[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.userName,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontSize: 12),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  comment.commentText,
                                  maxLines: 5,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              Divider(color: Colors.grey, thickness: 0.5),
                        );
                      }
                    }

                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
