part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class AdminLoginButtonPressedEvent extends AuthenticationEvent {}

class UserLoginButtonPressedEvent extends AuthenticationEvent {
  final String username;
  final String password;

  UserLoginButtonPressedEvent({required this.username, required this.password});
}

class AdminButtonPressedEvent extends AuthenticationEvent {}

class DontHaveAccountButtonPressedEvent extends AuthenticationEvent {}

class SignUpButtonPressedEvent extends AuthenticationEvent {}

class AlreadyHaveAccountButtonPressedEvent extends AuthenticationEvent {}

class UserButtonPressedEvent extends AuthenticationEvent {}
