import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AdminLoginButtonPressedEvent>(adminLoginButtonPressedEvent);
    on<UserLoginButtonPressedEvent>(userLoginButtonPressedEvent);
    on<AdminButtonPressedEvent>(adminButtonPressedEvent);
    on<DontHaveAccountButtonPressedEvent>(dontHaveAccountButtonPressed);
    on<SignUpButtonPressedEvent>(signUpButtonPressed);
    on<AlreadyHaveAccountButtonPressedEvent>(alreadyHaveAccountButtonPressed);
    on<UserButtonPressedEvent>(userButtonPressedEvent);
  }

  FutureOr<void> adminLoginButtonPressedEvent(
      AdminLoginButtonPressedEvent event, Emitter<AuthenticationState> emit) {
    print("Admin Login Button Presesed");
  }

  FutureOr<void> userLoginButtonPressedEvent(
      UserLoginButtonPressedEvent event, Emitter<AuthenticationState> emit) {
    print("User Login Button Presesed");
  }

  FutureOr<void> adminButtonPressedEvent(
      AdminButtonPressedEvent event, Emitter<AuthenticationState> emit) {
    emit(AdminLoginState());
  }

  FutureOr<void> dontHaveAccountButtonPressed(
      DontHaveAccountButtonPressedEvent event,
      Emitter<AuthenticationState> emit) {
    emit(UserSignupState());
  }

  FutureOr<void> signUpButtonPressed(
      SignUpButtonPressedEvent event, Emitter<AuthenticationState> emit) {
    print("SignUp Button Presesed");
  }

  FutureOr<void> alreadyHaveAccountButtonPressed(
      AlreadyHaveAccountButtonPressedEvent event,
      Emitter<AuthenticationState> emit) {
    emit(UserLoginState());
  }

  FutureOr<void> userButtonPressedEvent(
      UserButtonPressedEvent event, Emitter<AuthenticationState> emit) {
    emit(UserLoginState());
  }
}
