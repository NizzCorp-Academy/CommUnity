import 'package:bloc/bloc.dart';
import 'package:community_helpboard/features/communities/application/usecases/get_communities_usecase.dart';
import 'package:community_helpboard/features/communities/application/usecases/get_my_communities_usecase.dart';

import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';
import 'package:meta/meta.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final ICommunityRepository repository;

  CommunityBloc(this.repository) : super(CommunityInitial()) {
    on<GetAllCommunitiesEvent>((event, emit) async {
      emit(CommunityLoading());
      final result = await GetCommunitiesUsecase(repository)();

      emit(CommunityLoaded(result));
    });
    on<LoadJoinedCommunities>((event, emit) async {
      emit(CommunityLoading());
      final resultFutures = await GetMyCommunitiesUsecase(repository)(
        event.userId,
      );
      final result = await Future.wait(resultFutures);

      emit(CommunityLoaded(result));
    });
    on<CreateCommunityEvent>((event, emit) async {
      emit(CommunityCreateInProgress());

      await repository.createCommunity(event.community);
      emit(CommunityCreateSuccess());
    });
    on<JoinCommunityEvent>((event, emit) async {
      emit(CommunityJoinInProgress());
      await repository.joinCommunity(
        communityId: event.communityId,
        userId: event.userId,
      );
      emit(CommunityJoinSuccess());
    });
  }
}
