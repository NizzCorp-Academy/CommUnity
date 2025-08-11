import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';
import 'package:community_helpboard/features/core/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCommunitiesList extends StatelessWidget {
  const MyCommunitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    //  final String uid = FirebaseAuth.instance.currentUser!.uid;
    return BlocProvider(
      create: (context) =>
          CommunityBloc(context.read<ICommunityRepository>())
            ..add(LoadJoinedCommunities('5aoVKDomtCWfxYO80DbUDYn9QcJ3')),

      child: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (context, state) {
          if (state is CommunityLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommunityLoaded) {
            final communities = state.communities;

            if (communities.isEmpty) {
              return const Center(child: Text('No communities available.'));
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: communities.length,
              itemBuilder: (context, index) {
                final community = communities[index];
                return Container(
                  margin: EdgeInsets.all(5),
                  clipBehavior: Clip.hardEdge,
                  width: 140,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: AppColors.kPrimaryColor,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0,
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                      BoxShadow(
                        spreadRadius: 0,
                        color: Color.fromRGBO(0, 0, 0, 0),
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/cover-image.png',
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),

                      SizedBox(height: 8),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            community.name,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontSize: 14,
                                  fontFamily: 'Inter-Regular',
                                ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${community.members.length} members',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
