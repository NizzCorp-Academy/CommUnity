import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/domain/entities/member.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';

class CommunityRepositoryImpl implements ICommunityRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createCommunity(Community community) async {
    try {
      await _firestore.collection('communities').add({
        'id': '',
        'admin': community.admin,
        'name': community.name,
        'description': community.description,
        'members': community.members,
      });
    } catch (e) {
      // ignore: avoid_print
      print('Failed to create community..');
    }
  }

  @override
  Future<List<Community>> getAllCommunities() async {
    final snapshot = await _firestore.collection('communities').get();

    return snapshot.docs
        .map(
          (document) => Community(
            id: document['id'],
            admin: document['admin'],
            name: document['name'],
            description: document['description'],
            members: document['members'],
          ),
        )
        .toList();
  }

  @override
  Future<void> joinCommunity({
    required String communityId,
    required String userId,
  }) async {
    await _firestore.collection('communities').doc(communityId).set({
      'members': FieldValue.arrayUnion([userId]),
    });

    await _firestore.collection('users').doc(userId).set({
      'communitiesList': FieldValue.arrayUnion([communityId]),
    });
  }

  @override
  Future<List<Future<Community>>> getJoinedCommunities(String userId) async {
    final snapshot = await _firestore.collection('users').doc(userId).get();
    final userData = snapshot.data();
    final List communitiesList = userData?['communitiesList'];

    return communitiesList.map((communityId) async {
      final communitySnapshot = await _firestore
          .collection('communities')
          .doc(communityId)
          .get();

      final userData = communitySnapshot.data();
      return Community(
        id: userData?['id'],
        admin: userData?['admin'],
        name: userData?['name'],
        description: userData?['description'],
        members: userData?['members'],
      );
    }).toList();
  }

  @override
  Future<void> removeMemberFromCommunity({
    required String userId,
    required String communityId,
  }) async {
    await _firestore.collection('communities').doc(communityId).update({
      'members': FieldValue.arrayRemove([userId]),
    });
  }

  @override
  Future<List<Future<Member>>> getCommunityMembers(String communityId) async {
    final snapshot = await _firestore
        .collection('communities')
        .doc(communityId)
        .get();

    final communityData = snapshot.data();
    final List memberIds = communityData?['members'];

    return memberIds.map((userId) async {
      final userSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .get();

      final userData = userSnapshot.data();
      return Member(name: userData?['name'], email: userData?['email']);
    }).toList();
  }

  @override
  Future<bool> isAdmin({required String communityId, required String userId}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Community>> searchCommunities(String query) {
    throw UnimplementedError();
  }
}
