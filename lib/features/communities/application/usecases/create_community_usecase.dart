import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';

class CreateCommunityUsecase {
  final ICommunityRepository repository;
  CreateCommunityUsecase(this.repository);
  Future<void> call(Community community) async {
    await repository.createCommunity(community);
  }
}
