part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

//LOG IN
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

//SIGN UP
class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpRequested({
    required this.name,
    required this.email,
    required this.password,
  });
}

//LOG OUT
class LogoutRequested extends AuthEvent {}

//IS LOGGED IN
class CheckUserLoggedIn extends AuthEvent {}
