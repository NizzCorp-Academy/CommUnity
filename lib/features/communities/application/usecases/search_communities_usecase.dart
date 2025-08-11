import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';

class SearchCommunitiesUseCase {
  final ICommunityRepository repository;

  SearchCommunitiesUseCase(this.repository);

  Future<List<Community>> call(String query) {
    return repository.searchCommunities(query);
  }
}
