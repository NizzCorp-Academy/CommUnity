import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/profile/application/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:community_helpboard/features/core/app_assets.dart';
import 'package:community_helpboard/features/profile/presentation/screens/profile_screen.dart';

class CommunitiesHeader extends StatelessWidget {
  final String userId;
  const CommunitiesHeader({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final double totalTopHeight =
        MediaQuery.of(context).padding.top + kToolbarHeight;

    return Container(
      alignment: Alignment.bottomCenter,
      height: totalTopHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Communities', style: Theme.of(context).textTheme.headlineSmall),
          GestureDetector(
            child: SvgPicture.asset(
              AppAssets.accountIcon,
              height: 24,
              width: 24,
            ),
            onTap: () {
              context.read<ProfileBloc>().add(LoadCurrentUserProfile(userId));
              context.read<CommunityBloc>().add(LoadMyCommunities(userId));

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
