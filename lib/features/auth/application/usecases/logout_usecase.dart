import 'package:community_helpboard/features/auth/domain/repositories/i_auth_repository.dart';

class LogoutUseCase {
  final IAuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() async {
    try {
      await repository.logout();
    } catch (e) {
      rethrow;
    }
  }
}
