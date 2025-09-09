part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

// HELP
class LoadHelpPosts extends PostEvent {
  final String communityId;
  LoadHelpPosts(this.communityId);
}

// ANNOUCEMENTS
class LoadAnnouncementPosts extends PostEvent {
  final String communityId;
  LoadAnnouncementPosts(this.communityId);
}

//LOST AND FOUND
class LoadLostAndFoundPosts extends PostEvent {
  final String communityId;
  LoadLostAndFoundPosts(this.communityId);
}

//GET COMMENT
class LoadComments extends PostEvent {
  final String postId;
  final String communityId;
  final String category;
  LoadComments({
    required this.postId,
    required this.communityId,
    required this.category,
  });
}

//ADD COMMENT
class AddCommentRequested extends PostEvent {
  final String postId;
  final String communityId;
  final String category;
  final String commentText;
  AddCommentRequested({
    required this.postId,
    required this.communityId,
    required this.category,
    required this.commentText,
  });
}

//CREATE POST
class CreatePost extends PostEvent {
  final Post post;
  CreatePost(this.post);
}

//SELECT CATEGORY
class SelectCategory extends PostEvent {
  final String category;
  SelectCategory(this.category);
}

//GET ALL POSTS
class LoadAllPosts extends PostEvent {
  final String communityId;
  LoadAllPosts(this.communityId);
}

//DELTE POST
class DeletePostRequested extends PostEvent {
  final String communityId;
  final String category;
  final String postId;

  DeletePostRequested({
    required this.communityId,
    required this.category,
    required this.postId,
  });
}
