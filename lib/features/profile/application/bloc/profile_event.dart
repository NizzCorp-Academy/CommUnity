part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

//GET USER PROFILE

class LoadCurrentUserProfile extends ProfileEvent {
  final String userId;
  LoadCurrentUserProfile(this.userId);
}

//EDIT PROFILE

class EditUserProfile extends ProfileEvent {
  final String name;
  final String userId;
  EditUserProfile({required this.name, required this.userId});
}
