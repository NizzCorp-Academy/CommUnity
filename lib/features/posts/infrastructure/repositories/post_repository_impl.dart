import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_helpboard/features/posts/domain/entities/comment.dart';

import 'package:community_helpboard/features/posts/domain/entities/post.dart';
import 'package:community_helpboard/features/posts/domain/repositories/i_post_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostRepositoryImpl extends IPostRepository {
  final CollectionReference communitiesRef = FirebaseFirestore.instance
      .collection('communities');

  //GET ALL POSTS (category)

  @override
  Future<List<Post>> getAllPosts({
    required String communityId,
    required String category,
  }) async {
    try {
      final postedDataList = await communitiesRef
          .doc(communityId)
          .collection('posts')
          .doc('main')
          .collection(category)
          .get();

      return postedDataList.docs.map((post) {
        return Post(
          userName: post['userName'],
          id: post['postId'],
          createdAt: post['createdAt'],
          communityId: communityId,
          category: post['category'],
          comments: post['comments'],
          description: post['description'],
          title: post['title'],
        );
      }).toList();
    } catch (e) {
      throw 'Failed to get posts.';
    }
  }

  //CREATE POST
  @override
  Future<void> createPost(Post post) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final user = FirebaseFirestore.instance.collection('users').doc(userId);
      final userData = await user.get();
      final useProfile = userData.data();

      final docRef = await communitiesRef
          .doc(post.communityId)
          .collection('posts')
          .doc('main')
          .collection(post.category)
          .add({
            'userName': useProfile?['name'],
            'comments': post.comments,
            'description': post.description,
            'title': post.title,
            'createdAt': post.createdAt,
            'category': post.category,
          });
      await docRef.update({'postId': docRef.id});
      await user.update({'postCount': FieldValue.increment(1)});
    } catch (e) {
      throw 'Failed to create post.';
    }
  }

  //GET COMMENT
  @override
  Future<List<Comment>> getComments({
    required String communityId,
    required String category,
    required String postId,
  }) async {
    try {
      final postData = await communitiesRef
          .doc(communityId)
          .collection('posts')
          .doc('main')
          .collection(category)
          .doc(postId)
          .get();

      final post = postData.data();
      final List comments = post?['comments'];

      return comments.map((comment) {
        return Comment(
          commentText: comment['comment'],
          userName: comment['userName'],
        );
      }).toList();
    } catch (e) {
      throw 'Failed to get comments.';
    }
  }

  // ADD COMMENT
  @override
  Future<void> addComment({
    required String communityId,
    required String category,
    required String postId,
    required String commentText,
  }) async {
    try {
      final user = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid);

      final userData = await user.get();
      final userProfile = userData.data();
      await communitiesRef
          .doc(communityId)
          .collection('posts')
          .doc('main')
          .collection(category)
          .doc(postId)
          .update({
            'comments': FieldValue.arrayUnion([
              {'comment': commentText, 'userName': userProfile?['name']},
            ]),
          });
      await user.update({'commentCount': FieldValue.increment(1)});
    } catch (e) {
      throw 'Failed to add comment.';
    }
  }

  //DELTE POST
  @override
  Future<void> deletePost({
    required String communityId,
    required String category,
    required String postId,
  }) async {
    try {
      await communitiesRef
          .doc(communityId)
          .collection('posts')
          .doc('main')
          .collection(category)
          .doc(postId)
          .delete();
    } catch (e) {
      throw 'Failed to delete post.';
    }
  }
}
