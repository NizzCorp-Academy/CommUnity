part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

//ERROR SHARED
class ProfileFailure extends ProfileState {
  final String message;

  ProfileFailure(this.message);
}

final class ProfileInitial extends ProfileState {}

//GET USER PROFILE

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  UserProfile profile;
  ProfileLoaded(this.profile);
}

//EDIT PROFILE

class ProfileUpdating extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final String message;
  ProfileUpdateSuccess(this.message);
}
