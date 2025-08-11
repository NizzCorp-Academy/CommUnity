import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';

class JoinCommunityUsecase {
  ICommunityRepository repository;
  JoinCommunityUsecase(this.repository);
  Future<void> call({
    required String communityId,
    required String userId,
  }) async {
    await repository.joinCommunity(communityId: communityId, userId: userId);
  }
}
