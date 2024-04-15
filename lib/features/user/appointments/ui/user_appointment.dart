import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/user/appointments/bloc/user_appointment_bloc.dart';
import 'package:fontend/features/user/get_appointment/ui/get_appointment.dart';
import 'package:fontend/utils/constants.dart';

class UserAppointmentPage extends StatelessWidget {
  const UserAppointmentPage({super.key});
  @override
  Widget build(BuildContext context) {
    final UserAppointmentBloc userAppointmentBloc = UserAppointmentBloc();
    return BlocConsumer<UserAppointmentBloc, UserAppointmentState>(
      bloc: userAppointmentBloc,
      listenWhen: (previous, current) => current is UserAppointmentActionState,
      buildWhen: (previous, current) => current is! UserAppointmentActionState,
      listener: (context, state) {
        if (state is NavigateToBookAppointmentPageActionState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return const GetAppointmentPage();
          }));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Appointment"),
            iconTheme: appBarIcontheme,
          ),
          bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height / 11,
            child: FloatingActionButton(
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              onPressed: () {
                userAppointmentBloc.add(BookAppointmentButtonClickedEvent());
              },
              backgroundColor: iconButtonColor,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Book Appointment",
                  style: appBartitleStyle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
