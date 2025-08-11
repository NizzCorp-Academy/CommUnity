part of 'community_bloc.dart';

@immutable
sealed class CommunityEvent {}
class GetAllCommunitiesEvent extends CommunityEvent{}
class LoadMyCommunities extends CommunityEvent {}
class LoadJoinedCommunities extends CommunityEvent {
  final String userId;
  LoadJoinedCommunities(this.userId);
}
class CreateCommunityEvent extends CommunityEvent {
  final Community community;
  CreateCommunityEvent(this.community);
}
class JoinCommunityEvent extends CommunityEvent {
  final String communityId;
  final String userId; 
  JoinCommunityEvent(this.communityId, this.userId);
}
class CommunityJoinInProgress extends CommunityState {}
class CommunityJoinSuccess extends CommunityState {}