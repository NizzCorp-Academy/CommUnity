import 'package:flutter/material.dart';
import 'package:community_helpboard/features/communities/presentation/pages/create_community_screen.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/all_communities_list.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/my_communities_list.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/community_header.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/community_search_field.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(14.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 40),
                const CommunityHeader(),
                const SizedBox(height: 17),
                const CommunitySearchField(),
                const SizedBox(height: 20),
                Text(
                  'My Communities',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 164, child: MyCommunitiesList()),
              ]),
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'All Communities',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 17),
                const AllCommunitiesList(),
                const SizedBox(height: 20),
                Center(
                  child: PrimaryButton(
                    width: 350,
                    height: 48,
                    radius: 12,
                    text: 'Create Community',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateCommunityScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
