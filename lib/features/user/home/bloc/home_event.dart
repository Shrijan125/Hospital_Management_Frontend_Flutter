part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class UserProfileButtonCLickedEvent extends HomeEvent {
  UserProfileButtonCLickedEvent();
}

class HomeInitialEvent extends HomeEvent {}
