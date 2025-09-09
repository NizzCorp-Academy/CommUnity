import 'package:community_helpboard/features/admin/presentation/widgets/member_list_view.dart';

import 'package:community_helpboard/features/admin/presentation/widgets/post_list_view.dart';
import 'package:community_helpboard/features/core/app_colors.dart';

import 'package:flutter/material.dart';

class AdminPanelScreen extends StatelessWidget {
  final String communityId;
  const AdminPanelScreen({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              width: double.infinity,
              height: MediaQuery.of(context).padding.top + kToolbarHeight + 30,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(229, 229, 229, 1),
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                'Admin Panel',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(229, 231, 235, 1),
                  ),
                ),
              ),
              child: TabBar(
                indicatorColor: AppColors.tertiaryColor,
                dividerColor: Colors.transparent,
                labelColor: AppColors.tertiaryColor,
                unselectedLabelStyle: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontSize: 16),

                labelStyle: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                tabs: [
                  Tab(text: "Posts"),
                  Tab(text: "Members"),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                children: [
                  PostListView(communityId: communityId),
                  MemberListView(communityId: communityId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
