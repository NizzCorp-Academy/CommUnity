import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_helpboard/features/posts/domain/entities/comment.dart';
import 'package:community_helpboard/features/posts/domain/entities/post.dart';
import 'package:community_helpboard/features/posts/domain/repositories/i_post_repository.dart';

class PostRepositoryImpl extends IPostRepository {
  final CollectionReference communitiesRef = FirebaseFirestore.instance
      .collection('communities');

  Future<String> _getPostId(communityId) async {
    final postDocsSnapsho = await communitiesRef
        .doc(communityId)
        .collection('posts')
        .get();

    return postDocsSnapsho.docs.first.id;
  }

  @override
  Future<void> createPost(Post post) async {
    try {
      String postDocId = await _getPostId(post.communityId);
      await communitiesRef
          .doc(post.communityId)
          .collection('posts')
          .doc(postDocId)
          .collection(post.category)
          .add({
            'comments': post.comments,
            'createdAt': post.createdAt,
            'description': post.description,
            'title': post.title,
            'imageUrl': post.imageUrl,
          });
    } catch (e) {
      // ignore: avoid_print
      print('Failed to create post..');
    }
  }

  @override
  Future<List<Post>> getAllPosts(String communityId, String category) async {
    try {
      String postDocId = await _getPostId(communityId);
      final snapshot = await communitiesRef
          .doc(communityId)
          .collection('posts')
          .doc(postDocId)
          .collection(category)
          .get();

      return snapshot.docs
          .map(
            (document) => Post(
              imageUrl: '',
              communityId: communityId,
              category: category,
              title: document['title'],
              comments: [],
              description: document['description'],
              createdAt: '',
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get post..');
    }
  }

  removePost(String communityId, String postId, String category) async {
    String postDocId = await _getPostId(communityId);

    await communitiesRef
        .doc(communityId)
        .collection('posts')
        .doc(postDocId)
        .collection(category)
        .doc(postId)
        .delete();
  }

  addComment(communityId, category, postId, comment) async {
    String postDocId = await _getPostId(communityId);

    await communitiesRef
        .doc(communityId)
        .collection('posts')
        .doc(postDocId)
        .collection(category)
        .doc(postId)
        .set({
          'comment': [
            FieldValue.arrayRemove([comment]),
          ],
        });
  }

  Future<Iterable<Comment>> viewcomment(communityId, category, postId) async {
    String postDocId = await _getPostId(communityId);

    final snaphshot = await communitiesRef
        .doc(communityId)
        .collection('posts')
        .doc(postDocId)
        .collection(category)
        .doc(postId)
        .get();
    final data = snaphshot.data();
    final List comment = data?['comment'];

    return comment.map((e) {
      return Comment();
    });
  }
}
