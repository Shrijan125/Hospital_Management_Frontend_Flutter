part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class EditProfileButtonCLickedEvent extends ProfileEvent {}

class LogoutButtonCLickedEvent extends ProfileEvent {}

class UpdateProfilePhotoButtonClickedEvent extends ProfileEvent {}
