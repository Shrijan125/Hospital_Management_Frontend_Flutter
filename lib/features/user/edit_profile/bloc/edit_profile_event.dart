part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

class SaveChangesButtonClickedEvent extends EditProfileEvent {
  final String oldPassword;
  final String newPassword;
  final String email;
  SaveChangesButtonClickedEvent(
      {required this.oldPassword,
      required this.newPassword,
      required this.email});
}

class CameraIconButtonClickedEvent extends EditProfileEvent {}
