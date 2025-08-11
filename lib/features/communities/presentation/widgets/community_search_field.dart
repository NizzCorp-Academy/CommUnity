import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommunitySearchField extends StatelessWidget {
  const CommunitySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search communities',
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/icons/search.svg'),
        ),
      ),
    );
  }
}
