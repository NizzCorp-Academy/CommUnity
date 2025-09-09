import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/domain/entities/community.dart';

import 'package:community_helpboard/features/communities/presentation/widgets/community_visibility_info.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/create_community_header.dart';
import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:community_helpboard/features/core/app_snack_bar.dart';

import 'package:community_helpboard/features/widgets/primary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCommunityScreen extends StatefulWidget {
  final String userId;

  const CreateCommunityScreen({super.key, required this.userId});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<CommunityBloc, CommunityState>(
      listenWhen: (previous, current) =>
          current is CreateCommunityFailure ||
          current is CreateCommunitySuccess,
      buildWhen: (previous, current) =>
          current is CreateCommunityLoading ||
          current is CreateCommunityFailure,
      listener: (context, state) {
        if (state is CreateCommunityFailure) {
          AppSnackBar.show(context, state.message);
        } else if (state is CreateCommunitySuccess) {
          AppSnackBar.show(context, state.message);
          context.read<CommunityBloc>().add(LoadMyCommunities(widget.userId));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        bool isLoading = state is CreateCommunityLoading;
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateCommunityHeader(),
                  const SizedBox(height: 20),
                  Text(
                    'Community Name',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a community name';
                      }
                      return null;
                    },

                    decoration: const InputDecoration(
                      hintText: 'Enter community name',

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Text(
                    'Community Description',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 120,
                    child: TextFormField(
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                        hintText: 'Describe your community...',
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : PrimaryActionButton(
                          boxShadow: AppShadows.primary,
                          buttonWidth: screenWidth * 0.912,
                          buttonHeight: screenHeight * 0.064,
                          borderRadius: 12,
                          label: 'Create Community',
                          labelWeight: FontWeight.w600,
                          labelSize: 16,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Community community = Community(
                                id: '',
                                admin: widget.userId,
                                name: _nameController.text.trim(),
                                description: _descriptionController.text.trim(),
                                members: [widget.userId],
                              );

                              context.read<CommunityBloc>().add(
                                CreateCommunity(community: community),
                              );
                              _nameController.clear();
                              _descriptionController.clear();
                            }
                          },
                          fontFamily: 'Inter-SemiBold',
                        ),
                  const SizedBox(height: 15),

                  Center(child: const CommunityVisibilityInfo()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
