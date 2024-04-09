import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fontend/network/user_requests/user_network_request.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<SaveChangesButtonClickedEvent>(saveChangesButtonClickedEvent);
  }

  FutureOr<void> saveChangesButtonClickedEvent(
      SaveChangesButtonClickedEvent event,
      Emitter<EditProfileState> emit) async {
    emit(SavingChangesState());
    var passwordResponse = await UserNetworkRequests.changeUserPassword(
        event.oldPassword, event.newPassword);
    Response emailResponse =
        await UserNetworkRequests.changeUserEmail(event.email);

    if (passwordResponse.statusCode != 200 || emailResponse.statusCode != 200) {
      emit(ErrorState());
      emit(ErrorActionState(errorMessage: "Something went wrong"));
    } else {
      var decodedResponse = jsonDecode(emailResponse.body);
      String accessToken = decodedResponse['data']['accessToken'];
      String refreshToken = decodedResponse['data']['refreshToken'];
      emit(ChangesSavedActionState(
          accessToken: accessToken, refreshToken: refreshToken));
    }
  }
}
