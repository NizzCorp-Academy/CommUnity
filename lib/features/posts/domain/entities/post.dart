import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userName;

  final String communityId;
  final String category;
  final List comments;

  final String description;
  final String title;

  final Timestamp createdAt;

  Post({
    required this.userName,
    required this.id,

    required this.createdAt,

    required this.communityId,
    required this.category,
    required this.comments,

    required this.description,
    required this.title,
  });
}
