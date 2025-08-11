import 'package:community_helpboard/features/posts/domain/entities/post.dart';
import 'package:community_helpboard/features/posts/domain/repositories/i_post_repository.dart';

class GetAllPostsUsecase {
  IPostRepository repository;
  GetAllPostsUsecase(this.repository);
  Future<List<Post>> call({
    required String communityId,
    required String category,
  }) async {
    return await repository.getAllPosts(communityId, category);
  }
}
