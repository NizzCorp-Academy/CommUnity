import 'package:community_helpboard/features/communities/presentation/widgets/primary_button.dart';
import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';
import 'package:community_helpboard/features/posts/domain/entities/post.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/icon_label_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(thickness: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
        ),
        leading: Center(
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(121, 168, 212, 1),
              ),
            ),
          ),
        ),
        title: Text(
          'Create Post',

          style: TextStyle(
            color: Color.fromRGBO(46, 46, 46, 1),
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            fontFamily: 'Inter-SemiBold',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',

                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter post title...'),
                ),
                SizedBox(height: 25),
                Text(
                  'Description',

                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 206,
                  child: TextField(
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: 'Write your post content here...',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Communites',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      IconLabelChip(
                        text: 'Help',
                        icon: 'assets/icons/h42.svg',
                        color: Color.fromRGBO(255, 229, 229, 1),
                        width: 86,
                      ),
                      SizedBox(width: 10),
                      IconLabelChip(
                        text: 'Announcements',
                        icon: 'assets/icons/h45.svg',
                        color: Color.fromRGBO(229, 240, 255, 1),
                        width: 165,
                      ),
                      SizedBox(width: 10),
                      IconLabelChip(
                        text: 'Lost & Found',
                        icon: 'assets/icons/pood.svg',
                        color: Color.fromRGBO(255, 249, 229, 1),
                        width: 143,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            PrimaryButton(
              width: 358,
              height: 56,
              radius: 12,
              text: 'Post',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              onTap: () {
                context.read<PostBloc>().add(
                  CreatePostEvent(
                    Post(
                      title: 'TITle',
                      description: 'for description',
                      communityId: 'hnq36Nn11cIV7nHdT240',
                      category: 'help',
                      comments: [],
                      createdAt: '',
                      imageUrl: '',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
