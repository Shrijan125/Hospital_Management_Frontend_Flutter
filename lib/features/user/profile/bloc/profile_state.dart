part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

abstract class ProfileActionState extends ProfileState {}

final class ProfileInitial extends ProfileState {}

class LogoutActionState extends ProfileActionState {}

class NavigateToEditProfileActionState extends ProfileActionState {}
