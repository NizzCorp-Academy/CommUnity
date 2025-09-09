import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const SignUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Full Name', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 10),
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(hintText: 'Enter your full name'),

          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Name cannot be empty';
            }
            return null;
          },
        ),

        SizedBox(height: 15),
        Text('Email Address', style: Theme.of(context).textTheme.titleSmall),
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
        SizedBox(height: 15),
        Text('Password', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 10),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(hintText: 'Create a password'),

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
