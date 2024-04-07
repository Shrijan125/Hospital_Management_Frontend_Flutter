import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fontend/network/user_requests/user_network_request.dart';
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

  FutureOr<void> userLoginButtonPressedEvent(UserLoginButtonPressedEvent event,
      Emitter<AuthenticationState> emit) async {
    var response =
        await UserNetworkRequests.loginUser(event.username, event.password);
    if (response.statusCode == 200) {
      emit(UserLoggedInActionState());
    } else {
      if (response.statusCode == 400) {
        emit(UserLoginErrorActionState(errorMessage: "Username is required"));
      } else if (response.statusCode == 404) {
        emit(UserLoginErrorActionState(errorMessage: "User does not exist"));
      } else if (response.statusCode == 401) {
        emit(UserLoginErrorActionState(errorMessage: "Invalid Credentials"));
      } else {
        emit(UserLoginErrorActionState(errorMessage: "Something went wrong"));
      }
    }
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
      SignUpButtonPressedEvent event, Emitter<AuthenticationState> emit) async {
    var response =
        await UserNetworkRequests.signUpUser("shrijan", "shreshth", "password");
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
