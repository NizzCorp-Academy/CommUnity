import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';

class RemoveMemberFromCommunityUseCase {
  final ICommunityRepository repository;

  RemoveMemberFromCommunityUseCase(this.repository);

  Future<void> call({required String communityId, required String userId}) {
    return repository.removeMemberFromCommunity(
      communityId: communityId,
      userId: userId,
    );
  }
}
