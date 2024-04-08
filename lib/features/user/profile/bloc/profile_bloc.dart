import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<EditProfileButtonCLickedEvent>(editProfileButtonCLickedEvent);
    on<LogoutButtonCLickedEvent>(logoutButtonCLickedEvent);
    on<UpdateProfilePhotoButtonClickedEvent>(
        updateProfilePhotoButtonClickedEvent);
  }

  FutureOr<void> updateProfilePhotoButtonClickedEvent(
      UpdateProfilePhotoButtonClickedEvent event, Emitter<ProfileState> emit) {}

  FutureOr<void> editProfileButtonCLickedEvent(
      EditProfileButtonCLickedEvent event, Emitter<ProfileState> emit) {
    emit(NavigateToEditProfileActionState());
  }

  FutureOr<void> logoutButtonCLickedEvent(
      LogoutButtonCLickedEvent event, Emitter<ProfileState> emit) {
    emit(LogoutActionState());
  }
}
