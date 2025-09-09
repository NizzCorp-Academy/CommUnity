import 'package:bloc/bloc.dart';
import 'package:community_helpboard/features/posts/domain/entities/comment.dart';
import 'package:community_helpboard/features/posts/domain/entities/post.dart';
import 'package:community_helpboard/features/posts/domain/repositories/i_post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final IPostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    // HELP
    on<LoadHelpPosts>((event, emit) async {
      try {
        emit(HelpPostsLoading());
        final posts = await repository.getAllPosts(
          communityId: event.communityId,
          category: 'help',
        );
        emit(HelpPostsLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    // ANNOUCEMENTS
    on<LoadAnnouncementPosts>((event, emit) async {
      try {
        emit(AnnouncementPostsLoading());
        final posts = await repository.getAllPosts(
          communityId: event.communityId,
          category: 'announcements',
        );
        emit(AnnouncementPostsLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    // LOST AND FOUND
    on<LoadLostAndFoundPosts>((event, emit) async {
      try {
        emit(LostAndFoundPostsLoading());
        final posts = await repository.getAllPosts(
          communityId: event.communityId,
          category: 'lost_and_found',
        );
        emit(LostAndFoundPostsLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    //GET COMMENT
    on<LoadComments>((event, emit) async {
      try {
        emit(CommentsLoading());
        final comments = await repository.getComments(
          category: event.category,
          communityId: event.communityId,
          postId: event.postId,
        );
        emit(CommentsLoaded(comments));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    //ADD COMMENT
    on<AddCommentRequested>((event, emit) async {
      try {
        await repository.addComment(
          category: event.category,
          postId: event.postId,
          communityId: event.communityId,
          commentText: event.commentText,
        );
        emit(CommentSuccess('Comment added successfully.'));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    //CREATE POST
    on<CreatePost>((event, emit) async {
      try {
        emit(PostCreating());
        await repository.createPost(event.post);

        emit(PostCreated("Post created successfully."));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
    //SELECT CATEGORY
    on<SelectCategory>((event, emit) {
      emit(CategorySelected(selectedCategory: event.category));
    });

    //GET ALL POSTS
    on<LoadAllPosts>((event, emit) async {
      try {
        emit(PostLoading());

        final helpPosts = await repository.getAllPosts(
          communityId: event.communityId,
          category: 'help',
        );
        final announcementPosts = await repository.getAllPosts(
          communityId: event.communityId,
          category: 'announcements',
        );

        final lostAndFoundPosts = await repository.getAllPosts(
          communityId: event.communityId,
          category: 'lost_and_found',
        );

        final allPosts = [
          ...helpPosts,
          ...announcementPosts,
          ...lostAndFoundPosts,
        ];

        emit(PostLoaded(allPosts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    //DELTE POST
    on<DeletePostRequested>((event, emit) async {
      try {
        emit(DeletePostLoading());
        await repository.deletePost(
          category: event.category,
          postId: event.postId,
          communityId: event.communityId,
        );
        emit(DeletePostSuccess("Post deleted successfully."));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
