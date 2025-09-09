import 'package:community_helpboard/features/auth/application/bloc/auth_bloc.dart';

import 'package:community_helpboard/features/core/app_snack_bar.dart';
import 'package:community_helpboard/features/profile/application/bloc/profile_bloc.dart';
import 'package:community_helpboard/features/profile/presentation/widgets/profile_button_list.dart';

import 'package:community_helpboard/features/profile/presentation/widgets/profile_community_list.dart';
import 'package:community_helpboard/features/profile/presentation/widgets/profile_header.dart';

import 'package:community_helpboard/features/profile/presentation/widgets/profile_stats_list.dart';
import 'package:community_helpboard/features/splash/presentation/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) => current is ProfileFailure,
      listener: (context, state) {
        if (state is ProfileFailure) {
          AppSnackBar.show(context, state.message);
        }
      },
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            current is LogoutSuccess || current is LogoutFailure,
        listener: (context, state) {
          if (state is LogoutSuccess) {
            AppSnackBar.show(context, state.message);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
              (route) => false,
            );
          } else if (state is LogoutFailure) {
            AppSnackBar.show(context, state.message);
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 44),
                ProfileHeader(),
                SizedBox(height: 20),
                ProfileButtonList(userId: userId),
                SizedBox(height: 45),
                ProfileStatsList(),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'My Communities',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                ProfileCommunityList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
