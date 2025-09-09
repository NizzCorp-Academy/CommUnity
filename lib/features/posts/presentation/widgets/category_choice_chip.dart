import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryChoiceChip extends StatelessWidget {
  final String label;
  final String iconAssetPath;
  final Color backgroundColor;
  final bool selected;
  final Function(bool) onSelected;

  const CategoryChoiceChip ({
    super.key,
    required this.label,
    required this.iconAssetPath,
    required this.backgroundColor,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      color: WidgetStatePropertyAll(backgroundColor),
      side: BorderSide.none,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9999)),
      ),
      avatar: SvgPicture.asset(iconAssetPath,width:13,height: 13,),
      labelStyle: Theme.of(context).textTheme.titleSmall,
      checkmarkColor: AppColors.primaryColor,
      label: Text(label),
      selected: selected,
      onSelected: onSelected, 
    );
  }
}
