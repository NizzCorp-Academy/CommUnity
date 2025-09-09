import 'package:community_helpboard/features/auth/domain/repositories/i_auth_repository.dart';

class SignUpUseCase {
  final IAuthRepository repository;
  SignUpUseCase(this.repository);
  Future<void> call({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await repository.signUp(email: email, password: password, name: name);
    } catch (e) {
      rethrow;
    }
  }
}
