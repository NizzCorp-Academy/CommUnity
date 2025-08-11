import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommunityHeader extends StatelessWidget {
  const CommunityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Communities', style: Theme.of(context).textTheme.headlineSmall),
          SvgPicture.asset('assets/icons/user.svg', height: 24, width: 24),
        ],
      ),
    );
  }
}
