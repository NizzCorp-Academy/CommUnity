import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommunityVisibilityNote extends StatelessWidget {
  const CommunityVisibilityNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/iconsh.svg', width: 16, height: 16),
        SizedBox(width: 4),

        Text(
          'Your community will be visible to all users',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
