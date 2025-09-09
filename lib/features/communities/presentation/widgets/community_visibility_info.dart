import 'package:community_helpboard/features/core/app_assets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommunityVisibilityInfo extends StatelessWidget {
  const CommunityVisibilityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssets.infoIconAsset, width: 16, height: 16),
        SizedBox(width: 4),
        Text(
          'Your community will be visible to all users',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
