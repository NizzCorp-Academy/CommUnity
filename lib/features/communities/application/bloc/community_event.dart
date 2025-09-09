part of 'community_bloc.dart';

@immutable
sealed class CommunityEvent {}

//GET MY COMMUNITIIES
class LoadMyCommunities extends CommunityEvent {
  final String userId;
  LoadMyCommunities(this.userId);
}

//GET ALL COMMUNITIES
class LoadAllCommunities extends CommunityEvent {
  final String userId;
  LoadAllCommunities(this.userId);
}

//SEARCH COMMUNITIEIS
class SearchCommunities extends CommunityEvent {
  final String query;
  SearchCommunities(this.query);
}

//JOIN COMMUNITY
class JoinCommunity extends CommunityEvent {
  final String userId;
  final String communityId;

  JoinCommunity({required this.userId, required this.communityId});
}

//CREATE COMMUNITY
class CreateCommunity extends CommunityEvent {
  final Community community;

  CreateCommunity({required this.community});
}

//IS ADMIN
class CheckAdminStatus extends CommunityEvent {
  final String userId;
  final String communityId;

  CheckAdminStatus({required this.userId, required this.communityId});
}

//GET ALL COMMUNITY MEMBERS
class LoadCommunityMembers extends CommunityEvent {
  final String communityId;
  LoadCommunityMembers(this.communityId);
}

//DELETE MEMBERS
class DeleteMemberRequested extends CommunityEvent {
  final String userId;
  final String communityId;
  DeleteMemberRequested({required this.userId, required this.communityId});
}
