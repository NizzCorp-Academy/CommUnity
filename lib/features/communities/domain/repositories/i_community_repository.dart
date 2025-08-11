import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/domain/entities/member.dart';

abstract class ICommunityRepository {
  Future<void> createCommunity(Community community);
  Future<List<Community>> getAllCommunities();
  Future<void> joinCommunity({
    required String communityId,
    required String userId,
  });
   Future<List<Future<Community>>>getJoinedCommunities(String userId);
  Future<void> removeMemberFromCommunity({required String userId, required String communityId});
  Future<List<Future<Member>>>getCommunityMembers(String communityId);
  Future<bool> isAdmin({required String communityId, required String userId});
  Future<List<Community>> searchCommunities(String query);
}
