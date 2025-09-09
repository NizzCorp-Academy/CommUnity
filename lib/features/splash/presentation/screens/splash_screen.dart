import 'package:community_helpboard/features/auth/application/bloc/auth_bloc.dart';
import 'package:community_helpboard/features/auth/presentation/screens/login_screen.dart';
import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/presentation/screens/community_home_screen.dart';

import 'package:community_helpboard/features/core/app_assets.dart';
import 'package:community_helpboard/features/core/app_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthLoggedIn || current is AlreadyLoggedInFailure,
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          if (state.isLoggedIn == true) {
            final String userId = FirebaseAuth.instance.currentUser!.uid;

            Future.delayed(Duration(seconds: 5), () {
              // ignore: use_build_context_synchronously
              context.read<CommunityBloc>().add(LoadAllCommunities(userId));
              // ignore: use_build_context_synchronously
              context.read<CommunityBloc>().add(LoadMyCommunities(userId));

              Navigator.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => CommunityHomeScreen()),
                (route) => false,
              );
            });
          } else {
            Future.delayed(Duration(seconds: 5), () {
              Navigator.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            });
          }
        } else if (state is AlreadyLoggedInFailure) {
          AppSnackBar.show(context, state.message);
        }
      },
      child: Scaffold(
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.appLogo,
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Community',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),

                    SizedBox(height: 40),

                    SvgPicture.asset(AppAssets.splashThreeDots),
                  ],
                ),
              ),

              Image.asset(
                AppAssets.splashSquare,
                fit: BoxFit.fill,
                height: 128,
                width: screenWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
