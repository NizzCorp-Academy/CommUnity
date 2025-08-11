import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';

class GetCommunityMembersUseCase {
  final ICommunityRepository repository;

  GetCommunityMembersUseCase(this.repository);

  call(String communityId) {
    return repository.getCommunityMembers(communityId);
  }
}
