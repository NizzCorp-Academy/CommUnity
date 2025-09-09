import 'package:community_helpboard/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:flutter/material.dart';

class SignUpLinkRow extends StatelessWidget {
  const SignUpLinkRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text(
            'Sign Up',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColors.tertiaryColor),
          ),
        ),
      ],
    );
  }
}
