part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

// SHARED ERROR
class PostError extends PostState {
  final String message;

  PostError(this.message);
}

// LOST AND FOUND
class LostAndFoundPostsLoading extends PostState {}

class LostAndFoundPostsLoaded extends PostState {
  final List<Post> posts;
  LostAndFoundPostsLoaded(this.posts);
}

// ANNOUCEMENTS
class AnnouncementPostsLoading extends PostState {}

class AnnouncementPostsLoaded extends PostState {
  final List<Post> posts;
  AnnouncementPostsLoaded(this.posts);
}

// HELP
class HelpPostsLoading extends PostState {}

class HelpPostsLoaded extends PostState {
  final List<Post> posts;
  HelpPostsLoaded(this.posts);
}

//GET COMMENT
class CommentsLoading extends PostState {}

class CommentsLoaded extends PostState {
  List<Comment> comments;
  CommentsLoaded(this.comments);
}

//ADD COMMENT
class CommentSuccess extends PostState {
  final String message;
  CommentSuccess(this.message);
}

//CREATE POST
class PostCreating extends PostState {}

class PostCreated extends PostState {
  final String message;
  PostCreated(this.message);
}

//SELECT CATEGORY
class CategorySelected extends PostState {
  final String selectedCategory;
  CategorySelected({required this.selectedCategory});
}

//GET ALL POSTS
class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);
}

//DELTE POST
class DeletePostLoading extends PostState {}

class DeletePostSuccess extends PostState {
  final String message;
  DeletePostSuccess(this.message);
}
