import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/user/appointments/bloc/user_appointment_bloc.dart';
import 'package:fontend/features/user/get_appointment/ui/get_appointment.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/appointment_list_tile.dart';

class UserAppointmentPage extends StatefulWidget {
  const UserAppointmentPage({super.key});

  @override
  State<UserAppointmentPage> createState() => _UserAppointmentPageState();
}

class _UserAppointmentPageState extends State<UserAppointmentPage> {
  final userAppointmentBloc = UserAppointmentBloc();

  @override
  void initState() {
    userAppointmentBloc.add(AppointmentInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        switch (state.runtimeType) {
          case const (UserAppointmentLoadingSuccessState):
            final successState = state as UserAppointmentLoadingSuccessState;
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
                      userAppointmentBloc
                          .add(BookAppointmentButtonClickedEvent());
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
                body: successState.appoinments.isEmpty
                    ? const Center(
                        child: Text(
                          "You have no scheduled appointments.",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              "Your upcoming appointments are",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: successState.appoinments.length,
                                itemBuilder: (ctx, index) {
                                  return AppointmentListTile(
                                      doctorName: successState
                                          .appoinments[index].doctorName,
                                      profilePhoto: successState
                                          .appoinments[index].profilePhoto,
                                      time:
                                          successState.appoinments[index].time);
                                }),
                          ),
                        ],
                      ));
          case const (UserAppointmentLoadingErrorState):
            final successState = state as UserAppointmentLoadingErrorState;
            return Scaffold(
              body: Center(
                child: Text(
                  successState.errorMessage,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          case const (UserAppointmentLoadingState):
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: appBarColor,
                ),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text(
                  "Something went Wrong.\n Try again later.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            );
        }
      },
    );
  }
}
