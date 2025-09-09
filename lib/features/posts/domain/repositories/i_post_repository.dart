import 'package:community_helpboard/features/posts/domain/entities/comment.dart';
import 'package:community_helpboard/features/posts/domain/entities/post.dart';

abstract class IPostRepository {
  Future<void> createPost(Post post);


  Future<void> addComment({
    required String communityId,
    required String category,
    required String postId,
    required String commentText,
  });

  Future<List<Comment>> getComments({
    required String communityId,
    required String category,
    required String postId,
  });

  Future<List<Post>> getAllPosts({
    required String communityId,
    required String category,
  });
    Future<void> deletePost({
    required String communityId,
    required String category,
    required String postId,
  });

}
