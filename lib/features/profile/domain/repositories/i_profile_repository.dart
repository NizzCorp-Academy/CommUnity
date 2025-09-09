

import '../entities/user_profile.dart';

abstract class IProfileRepository {
 Future<UserProfile> getCurrentUserProfile(String userId);
  Future<void> editProfile({required String userId,required String userName});

}
