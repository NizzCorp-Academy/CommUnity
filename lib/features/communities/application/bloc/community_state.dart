part of 'community_bloc.dart';

@immutable
sealed class CommunityState {}

final class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityLoaded extends CommunityState {
  final List<Community> communities;
  CommunityLoaded(this.communities);
}
class CommunityCreateInProgress extends CommunityState {}

class CommunityCreateSuccess extends CommunityState {}
