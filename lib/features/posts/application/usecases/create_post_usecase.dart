import 'package:community_helpboard/features/posts/domain/entities/post.dart';
import 'package:community_helpboard/features/posts/domain/repositories/i_post_repository.dart';

class CreatePostUsecase {
  final IPostRepository repository;
  CreatePostUsecase(this.repository);
  Future<void> call(Post post) async {
    await repository.createPost(post);
  }
}
