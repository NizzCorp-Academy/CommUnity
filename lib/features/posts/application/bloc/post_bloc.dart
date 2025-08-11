import 'package:bloc/bloc.dart';
import 'package:community_helpboard/features/posts/domain/entities/post.dart';
import 'package:community_helpboard/features/posts/domain/repositories/i_post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final IPostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<GetAllPostsEvent>((event, emit) async {
      emit(PostLoading());

      final posts = await postRepository.getAllPosts(
        event.communityId,
        event.category,
      );
      emit(PostLoaded(posts));
    });

    on<CreatePostEvent>((event, emit) async {
      emit(PostCreating());

      await postRepository.createPost(event.post);
      emit(PostCreateSuccess());
    });
  }
}
