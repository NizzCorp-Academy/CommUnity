import 'package:community_helpboard/features/core/app_assets.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/core/app_shadows.dart';
import 'package:community_helpboard/features/profile/application/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.261,
      decoration: BoxDecoration(
        boxShadow: AppShadows.primary,
        color: AppColors.background,
      ),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            current is ProfileLoaded ||
            current is ProfileLoading ||
            current is ProfileFailure,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final profile = state.profile;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.defaultProfileImage,
                  width: 80,
                  height: 80,
                ),
                SizedBox(height: 20),
                Text(
                  profile.fullName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 10),
                Text(
                  profile.email,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 16),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
