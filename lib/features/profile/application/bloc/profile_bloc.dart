import 'package:bloc/bloc.dart';
import 'package:community_helpboard/features/profile/domain/entities/user_profile.dart';
import 'package:community_helpboard/features/profile/domain/repositories/i_profile_repository.dart';

import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    //GET USER PROFILE
    on<LoadCurrentUserProfile>((event, emit) async {
      try {
        emit(ProfileLoading());
        final profile = await repository.getCurrentUserProfile(event.userId);
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileFailure(e.toString()));
      }
    });
    //EDIT PROFILE
    on<EditUserProfile>((event, emit) async {
      try {
        emit(ProfileUpdating());

        await repository.editProfile(
          userName: event.name,
          userId: event.userId,
        );
        emit(ProfileUpdateSuccess('Updated name successfully.'));
      } catch (e) {
        emit(ProfileFailure(e.toString()));
      }
    });
  }
}
