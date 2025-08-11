import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';

class IsAdminUseCase {
  final ICommunityRepository repository;

  IsAdminUseCase(this.repository);

  Future<bool> call({
    required String communityId,
    required String userId,
  }) {
    return repository.isAdmin(communityId: communityId, userId: userId);
  }
}
