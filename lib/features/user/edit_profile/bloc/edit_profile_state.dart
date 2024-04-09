part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

abstract class EditProfileActionState extends EditProfileState {}

class ChangesSavedActionState extends EditProfileActionState {
  final String accessToken;
  final String refreshToken;

  ChangesSavedActionState(
      {required this.accessToken, required this.refreshToken});
}

class SavingChangesState extends EditProfileState {}

class ErrorState extends EditProfileState {}

class ErrorActionState extends EditProfileActionState {
  final String errorMessage;

  ErrorActionState({required this.errorMessage});
}
