import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Email', style: Theme.of(context).textTheme.titleSmall),
        ),

        SizedBox(height: 10),

        TextFormField(
          controller: emailController,
          decoration: InputDecoration(hintText: 'Enter your email'),

          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email cannot be empty';
            }

            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

            if (!emailRegex.hasMatch(value.trim())) {
              return 'Enter a valid email address';
            }

            return null;
          },
        ),
        SizedBox(height: 10),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Password',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(hintText: 'Enter your password'),

          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Password cannot be empty';
            }
            if (value.trim().length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
        ),
      ],
    );
  }
}
