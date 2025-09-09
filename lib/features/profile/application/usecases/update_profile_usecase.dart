import 'package:community_helpboard/features/profile/domain/repositories/i_profile_repository.dart';

class UpdateProfileUseCase {
  final IProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(String userName,String userId) async {
    return await repository.editProfile(userId: userId,userName: userName);
  }
}
