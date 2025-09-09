import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:community_helpboard/features/profile/domain/entities/user_profile.dart';
import 'package:community_helpboard/features/profile/domain/repositories/i_profile_repository.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //GET USER PROFILE
  @override
  Future<UserProfile> getCurrentUserProfile(String userId) async {
    try {
      final userData = await _firestore.collection('users').doc(userId).get();
      final user = userData.data();
      return UserProfile(
        postCount: user?['postCount'],
        commentCount: user?['commentCount'],
        fullName: user?['name'],
        email: user?['email'],
        uid: user?['id'],
      );
    } catch (e) {
      throw 'Failed to get profile.';
    }
  }

  //EDIT PROFILE
  @override
  Future<void> editProfile({
    required String userName,
    required String userId,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'name': userName,
      });
    } catch (e) {
      throw 'Profile update failed.';
    }
  }
}
