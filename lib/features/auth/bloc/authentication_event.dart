part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class AdminLoginButtonPressedEvent extends AuthenticationEvent {}

class UserLoginButtonPressedEvent extends AuthenticationEvent {}

class AdminButtonPressedEvent extends AuthenticationEvent {}

class DontHaveAccountButtonPressedEvent extends AuthenticationEvent {}

class SignUpButtonPressedEvent extends AuthenticationEvent {}

class AlreadyHaveAccountButtonPressedEvent extends AuthenticationEvent {}

class UserButtonPressedEvent extends AuthenticationEvent {}
