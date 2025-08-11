import 'package:community_helpboard/features/posts/presentation/widgets/category_chip.dart';
import 'package:flutter/material.dart';

class CommunityPostCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final String text;
  final double width;
  const CommunityPostCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.text,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      height: 176,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 2,
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CategoryChip(width: width, color: color, text: text),
                const SizedBox(width: 8),
                Text(
                  '2 hours ago',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Color.fromRGBO(107, 114, 128, 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text(
              description,
              maxLines: 3,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
                color: Color.fromRGBO(75, 85, 99, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
