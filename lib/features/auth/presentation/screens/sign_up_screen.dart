import 'package:community_helpboard/features/auth/application/bloc/auth_bloc.dart';
import 'package:community_helpboard/features/auth/presentation/widgets/sign_in_link_row.dart';
import 'package:community_helpboard/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/presentation/screens/community_home_screen.dart';
import 'package:community_helpboard/features/core/app_assets.dart';
import 'package:community_helpboard/features/core/app_snack_bar.dart';
import 'package:community_helpboard/features/widgets/primary_action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is SignUpSuccess || current is SignUpFailure,
      buildWhen: (previous, current) =>
          current is AuthLoading || current is SignUpFailure,
      listener: (context, state) {
        if (state is SignUpSuccess) {
          AppSnackBar.show(context, state.message);

          final String userId = FirebaseAuth.instance.currentUser!.uid;

          context.read<CommunityBloc>().add(LoadAllCommunities(userId));
          context.read<CommunityBloc>().add(LoadMyCommunities(userId));

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CommunityHomeScreen()),
            (route) => false,
          );
        } else if (state is SignUpFailure) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Community Connect',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Community Connect',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 18),
                    ),
                    SizedBox(height: 60),
                    SignUpForm(
                      nameController: nameController,
                      passwordController: passwordController,
                      emailController: emailController,
                    ),
                    SizedBox(height: 20),

                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Center(
                            child: PrimaryActionButton(
                              buttonWidth: screenWidth * 0.912,
                              buttonHeight: screenHeight * 0.069,
                              borderRadius: 12,
                              label: 'Sign Up',
                              labelWeight: FontWeight.w600,
                              labelSize: 16,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    SignUpRequested(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      name: nameController.text.trim(),
                                    ),
                                  );
                                  emailController.clear();
                                  passwordController.clear();
                                  nameController.clear();
                                }
                              },
                              fontFamily: 'Inter-SemiBold',
                            ),
                          ),
                    SizedBox(height: 10),
                    SignInLinkRow(),
                    SizedBox(height: 15),
                    SvgPicture.asset(AppAssets.termsPrivacy),
                    SizedBox(height: 15),
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
