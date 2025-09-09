import 'package:community_helpboard/features/auth/domain/repositories/i_auth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  Future<void> call({required String email,required String password}) async {
    try {
      await repository.login(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
