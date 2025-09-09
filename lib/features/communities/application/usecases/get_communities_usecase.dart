import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';

class GetCommunitiesUsecase {
  final ICommunityRepository repository;
  GetCommunitiesUsecase(this.repository);
  Future<List<Community>> call(useriD) async {
    return await repository.getAllCommunities(useriD);
  }
}
