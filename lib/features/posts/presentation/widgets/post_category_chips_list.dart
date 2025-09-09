import 'package:community_helpboard/features/core/app_assets.dart';
import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';

import 'package:community_helpboard/features/posts/presentation/widgets/category_choice_chip.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCategoryChipsList extends StatelessWidget {
  String? selectedCategory = 'help';
  PostCategoryChipsList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: BlocBuilder<PostBloc, PostState>(
        buildWhen: (previous, current) =>
            current is CategorySelected || current is PostError,
        builder: (context, state) {
          if (state is CategorySelected) {
            selectedCategory = state.selectedCategory;
          }
          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CategoryChoiceChip(
                label: 'Help',
                iconAssetPath: AppAssets.helpIconAsset,
                backgroundColor: const Color.fromRGBO(255, 229, 229, 1),
                selected: selectedCategory == 'help',
                onSelected: (bool isSelected) {
                  context.read<PostBloc>().add(SelectCategory('help'));
                },
              ),
              const SizedBox(width: 10),
              CategoryChoiceChip(
                label: 'Announcements',
                iconAssetPath: AppAssets.announcementIconAsset,
                backgroundColor: const Color.fromRGBO(229, 240, 255, 1),
                selected: selectedCategory == 'announcements',
                onSelected: (bool isSelected) {
                  context.read<PostBloc>().add(SelectCategory('announcements'));
                },
              ),
              const SizedBox(width: 10),
              CategoryChoiceChip(
                label: 'Lost & Found',
                iconAssetPath: AppAssets.lostAndFoundIconAsset,
                backgroundColor: const Color.fromRGBO(255, 249, 229, 1),
                selected: selectedCategory == 'lost_and_found',
                onSelected: (bool isSelected) {
                  context.read<PostBloc>().add(
                    SelectCategory('lost_and_found'),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
