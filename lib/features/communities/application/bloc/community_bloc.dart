import 'package:bloc/bloc.dart';

import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/domain/entities/member.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';
import 'package:meta/meta.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final ICommunityRepository repository;

  CommunityBloc(this.repository) : super(CommunityInitial()) {
    //GET MY COMMUNITIIES
    on<LoadMyCommunities>((event, emit) async {
      try {
        emit(MyCommunitiesLoading());
        final futures = await repository.getMyCommunities(event.userId);
        final communities = await Future.wait(futures);

        emit(MyCommunitiesLoaded(communities));
      } catch (e) {
        emit(CommunityError(e.toString()));
      }
    });
    //GET ALL COMMUNITIIES
    on<LoadAllCommunities>((event, emit) async {
      try {
        emit(CommunityLoading());
        final communities = await repository.getAllCommunities(event.userId);
        emit(CommunityLoaded(communities));
      } catch (e) {
        emit(CommunityError(e.toString()));
      }
    });
    //JOIN COMMUNITY
    on<JoinCommunity>((event, emit) async {
      try {
        emit(JoinCommunityLoading());
        await repository.joinCommunity(
          communityId: event.communityId,
          userId: event.userId,
        );
        emit(JoinCommunitySuccess('Community joined successfully.'));
      } catch (e) {
        emit(CommunityError(e.toString()));
      }
    });

    //SEARCH COMMUNITIEIS
    on<SearchCommunities>((event, emit) async {
      try {
        emit(CommunitySearchLoading());
        final results = await repository.searchCommunities(event.query);
        emit(CommunitySearchResult(results));
      } catch (e) {
        emit(CommunityError(e.toString()));
      }
    });
    //CREATE COMMUNITY
    on<CreateCommunity>((event, emit) async {
      try {
        emit((CreateCommunityLoading()));
        await repository.createCommunity(event.community);
        emit(CreateCommunitySuccess('Community created successfull.'));
      } catch (e) {
        emit(CreateCommunityFailure(e.toString()));
      }
    });

    //IS ADMIN
    on<CheckAdminStatus>((event, emit) async {
      try {
        final result = await repository.isAdmin(
          communityId: event.communityId,
          userId: event.userId,
        );
        emit(AdminIdentified(result));
      } catch (e) {
        emit(CommunityError(e.toString()));
      }
    });
    //GET ALL COMMUNITY MEMBERS
    on<LoadCommunityMembers>((event, emit) async {
      try {
        emit(MemberLoading());
        final futures = await repository.getCommunityMembers(event.communityId);
        final members = await Future.wait(futures);
        emit(MemberLoaded(members));
      } catch (e) {
        emit(CommunityError(e.toString()));
      }
    });
    //DELETE MEMBERS
    on<DeleteMemberRequested>((event, emit) async {
      try {
        emit(DeleteMemberLoading());
        await repository.deleteMembers(
          communityId: event.communityId,
          userId: event.userId,
        );
        emit(DeleteMemberSuccess('Member deleted successfully.'));
      } catch (e) {
        emit(CommunityError(e.toString()));
      }
    });
  }
}
