part of 'community_bloc.dart';

@immutable
sealed class CommunityState {}

final class CommunityInitial extends CommunityState {}

// SHARED ERROR
class CommunityError extends CommunityState {
  final String message;
  CommunityError(this.message);
}

//GET MY COMMUNITIIES
class MyCommunitiesLoading extends CommunityState {}

class MyCommunitiesLoaded extends CommunityState {
  final List<Community> communities;
  MyCommunitiesLoaded(this.communities);
}

//GET ALL COMMUNITIES
class CommunityLoading extends CommunityState {}

class CommunityLoaded extends CommunityState {
  final List<Community> communities;

  CommunityLoaded(this.communities);
}

//JOIN COMMUNITY
class JoinCommunityLoading extends CommunityState {}

class JoinCommunitySuccess extends CommunityState {
  final String message;
  JoinCommunitySuccess(this.message);
}

//SEARCH COMMUNITIIES
class CommunitySearchLoading extends CommunityState {}

class CommunitySearchResult extends CommunityState {
  final List<Community> communities;
  CommunitySearchResult(this.communities);
}

//CREATE COMMUNITY
class CreateCommunityLoading extends CommunityState {}

class CreateCommunitySuccess extends CommunityState {
  final String message;
  CreateCommunitySuccess(this.message);
}

class CreateCommunityFailure extends CommunityState {
  final String message;
  CreateCommunityFailure(this.message);
}

//IS ADMIN
class AdminIdentified extends CommunityState {
  bool isAdmin;
  AdminIdentified(this.isAdmin);
}

//GET ALL COMMUNITY MEMBERS
class MemberLoading extends CommunityState {}

class MemberLoaded extends CommunityState {
  final List<Member> members;
  MemberLoaded(this.members);
}

//DELETE MEMBERS
class DeleteMemberLoading extends CommunityState {}

class DeleteMemberSuccess extends CommunityState {
  final String message;
  DeleteMemberSuccess(this.message);
}
