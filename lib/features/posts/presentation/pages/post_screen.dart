import 'package:community_helpboard/features/posts/presentation/pages/create_post_screen.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/announcement_post_list.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/help_post_list.dart';
import 'package:community_helpboard/features/posts/presentation/widgets/lost_and_found_post_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.white,

          elevation: 0,
          title: const Text(
            'Community Posts',
            style: TextStyle(
              color: Color.fromRGBO(46, 46, 46, 1),
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              fontFamily: 'Inter-SemiBold',
            ),
          ),
          bottom: TabBar(
            labelColor: Color.fromRGBO(121, 168, 212, 1),
            indicatorColor: Color.fromRGBO(121, 168, 212, 1),

            labelStyle: Theme.of(context).textTheme.bodyMedium,
            tabs: [
              Tab(text: "Help"),
              Tab(text: "Announcements"),
              Tab(text: "Lost & Found"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HelpPostList(),
            AnnouncementPostList(),
            LostAndFoundPostList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: const StadiumBorder(),
          backgroundColor: const Color.fromRGBO(121, 168, 212, 1),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatePostScreen()),
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
