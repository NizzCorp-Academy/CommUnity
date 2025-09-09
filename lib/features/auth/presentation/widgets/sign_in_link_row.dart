import 'package:community_helpboard/features/auth/presentation/screens/login_screen.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:flutter/material.dart';

class SignInLinkRow extends StatelessWidget {
  const SignInLinkRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16,color: AppColors.textPrimary),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text(
            'Login',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.tertiaryColor,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
