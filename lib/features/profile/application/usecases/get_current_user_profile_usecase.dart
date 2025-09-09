import 'package:community_helpboard/features/profile/domain/entities/user_profile.dart';
import 'package:community_helpboard/features/profile/domain/repositories/i_profile_repository.dart';

class GetCurrentUserProfileUsecase {
  final IProfileRepository repository;
  GetCurrentUserProfileUsecase(this.repository);

  Future<UserProfile> call(String userId) {
    return repository.getCurrentUserProfile(userId);
  }
}
