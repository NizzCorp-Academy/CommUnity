import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:community_helpboard/features/core/app_snack_bar.dart';
import 'package:community_helpboard/features/profile/application/bloc/profile_bloc.dart';
import 'package:community_helpboard/features/widgets/primary_action_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final String userId;
  const EditProfileScreen({super.key, required this.userId});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          current is ProfileUpdateSuccess || current is ProfileFailure,
      buildWhen: (previous, current) =>
          current is ProfileFailure || current is ProfileUpdating,
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          AppSnackBar.show(context, state.message);
          context.read<ProfileBloc>().add(
            LoadCurrentUserProfile(widget.userId),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final bool loading = state is ProfileUpdating;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Edit Profile',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: "Enter new name"),
                    controller: _nameController,

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 13),
                  loading
                      ? CircularProgressIndicator()
                      : PrimaryActionButton(
                          buttonWidth: screenWidth * 0.267,
                          buttonHeight: screenHeight * 0.049,
                          borderRadius: 12,
                          label: 'Save',
                          labelWeight: FontWeight.w600,
                          labelSize: 16,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ProfileBloc>().add(
                                EditUserProfile(
                                  name: _nameController.text.trim(),
                                  userId: widget.userId,
                                ),
                              );
                              _nameController.clear();
                            }
                          },
                          fontFamily: 'Inter-SemiBold',
                          boxShadow: AppShadows.primary,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
