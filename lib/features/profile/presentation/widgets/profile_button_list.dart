import 'package:community_helpboard/features/auth/application/bloc/auth_bloc.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:community_helpboard/features/profile/presentation/widgets/profile_action_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileButtonList extends StatelessWidget {
  final String userId;

  const ProfileButtonList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        ProfileActionButton(
          buttonColor: AppColors.tertiaryColor,
          buttonWidth: screenWidth * 0.928,
          buttonHeight: screenHeight * 0.059,
          borderRadius: 12,
          label: 'Edit Profile',
          labelWeight: FontWeight.w600,
          labelSize: 16,
          labelColor: AppColors.primaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(userId: userId),
              ),
            );
          },
          fontFamily: 'Inter-SemiBold',
          icon: Icons.edit,
          iconSize: 20,
          iconColor: AppColors.primaryColor,
        ),
        SizedBox(height: 10),

        ProfileActionButton(
          buttonColor: Colors.transparent,
          buttonWidth: screenWidth * 0.928,
          buttonHeight: screenHeight * 0.059,
          borderRadius: 12,
          label: 'Logout',
          labelWeight: FontWeight.w600,
          labelSize: 16,
          labelColor: AppColors.tertiaryColor,
          onPressed: () {
            context.read<AuthBloc>().add(LogoutRequested());
          },
          fontFamily: 'Inter-SemiBold',
          icon: Icons.logout,
          iconSize: 20,
          iconColor: AppColors.tertiaryColor,
          borderColor: AppColors.tertiaryColor,
        ),
      ],
    );
  }
}
