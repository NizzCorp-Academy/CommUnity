import 'package:community_helpboard/features/auth/application/bloc/auth_bloc.dart';
import 'package:community_helpboard/features/auth/presentation/widgets/login_form.dart';

import 'package:community_helpboard/features/auth/presentation/widgets/sign_up_link_row.dart';
import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/presentation/screens/community_home_screen.dart';
import 'package:community_helpboard/features/core/app_assets.dart';
import 'package:community_helpboard/features/core/app_snack_bar.dart';
import 'package:community_helpboard/features/widgets/primary_action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is LoginSuccess || current is LoginFailure,
      buildWhen: (previous, current) =>
          current is AuthLoading || current is LoginFailure,
      listener: (context, state) {
        if (state is LoginSuccess) {
          AppSnackBar.show(context, state.message);

          final String userId = FirebaseAuth.instance.currentUser!.uid;

          context.read<CommunityBloc>().add(LoadAllCommunities(userId));
          context.read<CommunityBloc>().add(LoadMyCommunities(userId));

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CommunityHomeScreen(),
            ),
            (route) => false,
          );
        } else if (state is LoginFailure) {
          AppSnackBar.show(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: screenHeight,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.loginLogo,
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Welcome back',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Please sign in to continue',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 50),
                    LoginForm(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    SizedBox(height: 20),
                    isLoading
                        ? CircularProgressIndicator()
                        : PrimaryActionButton(
                            buttonWidth: screenWidth * 0.912,
                            buttonHeight: screenHeight * 0.069,
                            borderRadius: 12,
                            label: 'Log In',
                            labelWeight: FontWeight.w500,
                            labelSize: 16,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  LoginRequested(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                                emailController.clear();
                                passwordController.clear();
                              }
                            },
                            fontFamily: 'Inter-Medium',
                          ),
                    SizedBox(height: 5),
                    SignUpLinkRow(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
