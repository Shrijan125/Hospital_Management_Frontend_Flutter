part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

abstract class AuthenticationActionState extends AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

class AdminLoginState extends AuthenticationState {}

class UserLoginState extends AuthenticationState {}

class UserSignupState extends AuthenticationState {}

class LoginState extends AuthenticationState {}

class UserLoggedInActionState extends AuthenticationActionState {}

class UserLoginErrorActionState extends AuthenticationActionState {
  final String errorMessage;

  UserLoginErrorActionState({required this.errorMessage});
}