import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/domain/entities/member.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommunityRepositoryImpl implements ICommunityRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //GET MY COMMUNITIIES
  @override
  Future<List<Future<Community>>> getMyCommunities(String userId) async {
    try {
      final userProfile = await _firestore
          .collection('users')
          .doc(userId)
          .get();
      final user = userProfile.data();
      final List userCommunitiesIdList = user?['joinedCommunities'];
      return userCommunitiesIdList.map((communityId) async {
        final communityData = await _firestore
            .collection('communities')
            .doc(communityId)
            .get();
        final community = communityData.data();
        return Community(
          id: community?['id'],
          admin: community?['admin'],
          name: community?['name'],
          description: community?['description'],
          members: community?['members'],
        );
      }).toList();
    } catch (e) {
      throw 'Failed to get my communities.';
    }
  }

  //GET ALL COMMUNITIIES
  @override
  Future<List<Community>> getAllCommunities(String userId) async {
    try {
      final communitiesData = await _firestore.collection('communities').get();
      final communitiesList = communitiesData.docs.map((community) {
        return Community(
          id: community['id'],
          admin: community['admin'],
          name: community['name'],
          description: community['description'],
          members: List<String>.from(community['members']),
        );
      }).toList();

      return communitiesList.where((community) {
        return !community.members.contains(userId);
      }).toList();
    } catch (e) {
      throw 'Failed to get communities.';
    }
  }

  //JOIN COMMUNITY
  @override
  Future<void> joinCommunity({
    required String communityId,
    required String userId,
  }) async {
    try {
      await _firestore.collection('communities').doc(communityId).update({
        'members': FieldValue.arrayUnion([userId]),
      });

      await _firestore.collection('users').doc(userId).update({
        'joinedCommunities': FieldValue.arrayUnion([communityId]),
      });
    } catch (e) {
      throw 'Failed to join community.';
    }
  }

  //SEARCH COMMUNITIIES
  @override
  Future<List<Community>> searchCommunities(String query) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final allCommunities = await getAllCommunities(userId!);

      final results = allCommunities
          .where(
            (community) =>
                community.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      return results;
    } catch (e) {
      throw 'Failed to search communities.';
    }
  }

  //CREATE COMMUNITY
  @override
  Future<void> createCommunity(Community community) async {
    try {
      final communityWithId = _firestore.collection('communities').doc();

      await communityWithId.set({
        'id': communityWithId.id,
        'admin': community.admin,
        'name': community.name,
        'description': community.description,
        'members': community.members,
      });

      await _firestore.collection('users').doc(community.admin).update({
        'joinedCommunities': FieldValue.arrayUnion([communityWithId.id]),
      });
    } catch (e) {
      throw 'Failed to create community.';
    }
  }

  //IS ADMIN
  @override
  Future<bool> isAdmin({
    required String communityId,
    required String userId,
  }) async {
    try {
      final communityData = await _firestore
          .collection('communities')
          .doc(communityId)
          .get();
      final community = communityData.data();
      return community?['admin'] == userId;
    } catch (e) {
      throw 'Unable to verify admin access.';
    }
  }

  //GET ALL COMMUNITY MEMBERS
  @override
  Future<List<Future<Member>>> getCommunityMembers(String communityId) async {
    try {
      final communityData = await _firestore
          .collection('communities')
          .doc(communityId)
          .get();

      final community = communityData.data();
      final adminId = community?['admin'];
      final membersId = List<String>.from(community?['members']);
      membersId.remove(adminId);
      return membersId.map((memberId) async {
        final memberData = await _firestore
            .collection('users')
            .doc(memberId)
            .get();
        final member = memberData.data();
        return Member(id: member?['id'], name: member?['name']);
      }).toList();
    } catch (e) {
      throw 'Failed to get members.';
    }
  }

  //DELETE MEMBERS
  @override
  Future<void> deleteMembers({
    required String userId,
    required String communityId,
  }) async {
    try {
      await _firestore.collection('communities').doc(communityId).update({
        'members': FieldValue.arrayRemove([userId]),
      });
      await _firestore.collection('users').doc(userId).update({
        'joinedCommunities': FieldValue.arrayRemove([communityId]),
      });
    } catch (e) {
      throw 'Failed to remove member.';
    }
  }
}
