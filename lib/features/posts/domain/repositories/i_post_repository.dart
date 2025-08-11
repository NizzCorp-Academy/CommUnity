import 'package:community_helpboard/features/posts/domain/entities/post.dart';

abstract class IPostRepository {
  Future<void> createPost(Post post);
  Future<List<Post>> getAllPosts(String communityId, String category);
}
