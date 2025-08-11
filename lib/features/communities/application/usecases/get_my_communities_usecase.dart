import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';

class GetMyCommunitiesUsecase {
  final ICommunityRepository repository;

  GetMyCommunitiesUsecase(this.repository);
  Future<List<Future<Community>>> call(String userId) {
    return repository.getJoinedCommunities(userId);
  }
}
