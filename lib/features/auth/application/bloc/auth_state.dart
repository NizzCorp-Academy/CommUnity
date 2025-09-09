part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

//SHARED FOR LOADING

class AuthLoading extends AuthState {}

//LOG IN

class LoginSuccess extends AuthState {
  final String message;
  LoginSuccess(this.message);
}

class LoginFailure extends AuthState {
  final String message;
  LoginFailure(this.message);
}

//SIGN UP

class SignUpSuccess extends AuthState {
  final String message;
  SignUpSuccess(this.message);
}

class SignUpFailure extends AuthState {
  final String message;
  SignUpFailure(this.message);
}

//LOG OUT

class LogoutSuccess extends AuthState {
  final String message;
  LogoutSuccess(this.message);
}

class LogoutFailure extends AuthState {
  final String message;
  LogoutFailure(this.message);
}

//IS LOGGED IN

class AuthLoggedIn extends AuthState {
  bool isLoggedIn;
  AuthLoggedIn(this.isLoggedIn);
}

class AlreadyLoggedInFailure extends AuthState {
  final String message;
  AlreadyLoggedInFailure(this.message);
}
