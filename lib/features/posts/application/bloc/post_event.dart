part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class GetAllPostsEvent extends PostEvent {
  final String communityId;
  final String category;

  GetAllPostsEvent(this.communityId, this.category);
  
}
class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);
}
class CreatePostEvent extends PostEvent {
  final Post post;

  CreatePostEvent(this.post);
}