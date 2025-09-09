import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:community_helpboard/features/core/app_snack_bar.dart';
import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';
import 'package:community_helpboard/features/posts/domain/entities/post.dart';

import 'package:community_helpboard/features/posts/presentation/widgets/create_post_header.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/post_category_chips_list.dart';
import 'package:community_helpboard/features/widgets/primary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostScreen extends StatefulWidget {
  final String communityId;
  const CreatePostScreen({super.key, required this.communityId});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedCategory = 'help';
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<PostBloc, PostState>(
      listenWhen: (previous, current) =>
          current is PostError || current is PostCreated,
      buildWhen: (previous, current) =>
          current is PostCreated ||
          current is PostCreating ||
          current is PostError,
      listener: (context, state) {
        if (state is PostCreated) {
          AppSnackBar.show(context, state.message);
          context.read<PostBloc>().add(LoadHelpPosts(widget.communityId));

          context.read<PostBloc>().add(
            LoadAnnouncementPosts(widget.communityId),
          );

          context.read<PostBloc>().add(
            LoadLostAndFoundPosts(widget.communityId),
          );

          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is CategorySelected) {
          selectedCategory = state.selectedCategory;
        }
        bool isLoading = state is PostCreating;
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
                top: 0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreatePostHeader(),
                    SizedBox(height: 30),
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Enter post title...',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Title cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 10),

                    SizedBox(
                      height: 200,
                      child: TextFormField(
                        maxLength: 500,
                        controller: _descriptionController,
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          hintText: 'Write your post content here...',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Description cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: 30),
                    PostCategoryChipsList(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: isLoading
              ? SizedBox(
                  height: screenHeight * 0.069,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PrimaryActionButton(
                    buttonWidth: 0,
                    buttonHeight: screenHeight * 0.069,
                    borderRadius: 12,
                    label: 'Post',
                    labelWeight: FontWeight.w600,
                    labelSize: 16,
                    onPressed: () {
                      final state = context.read<PostBloc>().state;
                      if (state is CategorySelected) {
                        selectedCategory = state.selectedCategory;
                      }
                      if (_formKey.currentState!.validate()) {
                        final post = Post(
                          id: '',
                          createdAt: Timestamp.now(),
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          communityId: widget.communityId,
                          category: selectedCategory,
                          comments: [],
                          userName: '',
                        );
                        _titleController.clear();
                        _descriptionController.clear();
                        context.read<PostBloc>().add(CreatePost(post));
                      }
                    },

                    fontFamily: 'Inter-SemiBold',
                    boxShadow: AppShadows.primary,
                  ),
                ),
        );
      },
    );
  }
}
