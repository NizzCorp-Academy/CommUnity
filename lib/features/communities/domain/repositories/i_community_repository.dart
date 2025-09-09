import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/domain/entities/member.dart';

abstract class ICommunityRepository {
  Future<void> createCommunity(Community community);

  Future<bool> isAdmin({required String communityId, required String userId});
  Future<List<Community>> searchCommunities(String query);

  Future<void> joinCommunity({
    required String communityId,
    required String userId,
  });
  Future<List<Community>> getAllCommunities(String userId);
  Future<List<Future<Community>>> getMyCommunities(String userId);
  Future<List<Future<Member>>> getCommunityMembers(String communityId);

  Future<void> deleteMembers({
    required String userId,
    required String communityId,
  });
}
