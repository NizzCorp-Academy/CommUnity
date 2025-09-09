import 'package:bloc/bloc.dart';
import 'package:community_helpboard/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    //LOG IN
    on<LoginRequested>((event, emit) async {
      try {
        emit(AuthLoading());
        await repository.login(email: event.email, password: event.password);
        emit(LoginSuccess('Login successful.'));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
    //SIGN UP
    on<SignUpRequested>((event, emit) async {
      try {
        emit(AuthLoading());

        await repository.signUp(
          email: event.email,
          password: event.password,
          name: event.name,
        );

        emit(SignUpSuccess('Signup successful.'));
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
    //LOG OUT
    on<LogoutRequested>((event, emit) async {
      try {
        await repository.logout();
        emit(LogoutSuccess('Logout successful.'));
      } catch (e) {
        emit(LogoutFailure(e.toString()));
      }
    });
    //IS LOGGED IN
    on<CheckUserLoggedIn>((event, emit) async {
      try {
        emit(AuthLoggedIn(repository.isUserLoggedIn()));
      } catch (e) {
        emit(AlreadyLoggedInFailure(e.toString()));
      }
    });
  }
}
