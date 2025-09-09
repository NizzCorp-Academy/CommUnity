import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/core/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

class CommunitySearchBar extends StatelessWidget {
  final String userId;
  const CommunitySearchBar({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (value.isEmpty) {
          context.read<CommunityBloc>().add(LoadAllCommunities(userId));
        } else {
          context.read<CommunityBloc>().add(SearchCommunities(value));
        }
      },
      decoration: InputDecoration(
        hintText: 'Search communities',
        prefixIconConstraints: BoxConstraints(minWidth: 45, minHeight: 45),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 10),
          child: SvgPicture.asset(
            AppAssets.searchIcon,
            width: 16.21,
            height: 16.21,
          ),
        ),
      ),
    );
  }
}
