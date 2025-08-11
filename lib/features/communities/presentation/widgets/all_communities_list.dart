import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';

import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';

import 'package:community_helpboard/features/communities/presentation/widgets/primary_button.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCommunitiesList extends StatelessWidget {
  const AllCommunitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommunityBloc(context.read<ICommunityRepository>())
            ..add(GetAllCommunitiesEvent()),
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: communities.length,
              itemBuilder: (context, index) {
                final community = communities[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: 358,
                  height: 144,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: AppColors.kPrimaryColor,
                    boxShadow: const [
                      BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 2,
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/covimage.png',
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                community.name,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontFamily: 'Inter-Regular'),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                softWrap: true,
                                community.description,
                                maxLines: 2,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${community.members.length} members',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  GestureDetector(
                                    child: PrimaryButton(
                                      width: 60,
                                      height: 36,
                                      radius: 8,
                                      text: 'Join',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      onTap: () {
                                        context.read<CommunityBloc>().add(
                                          JoinCommunityEvent(
                                            '${community.id}',
                                            'TbL4JKHcFpOfz8wZUMDYpmdFOwZ2',
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
