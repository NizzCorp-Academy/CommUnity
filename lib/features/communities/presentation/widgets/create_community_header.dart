import 'package:flutter/material.dart';

class CreateCommunityHeader extends StatelessWidget {
  const CreateCommunityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double totalHeight =
        kToolbarHeight + MediaQuery.of(context).padding.top;

    return Container(
      height: totalHeight,
      width: double.infinity,
      padding: EdgeInsets.only(right: 15, bottom: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.1), width: 1),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              child: const Icon(
                Icons.chevron_left,
                color: Color.fromRGBO(46, 46, 46, 1),
                size: 30,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Create Community',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
