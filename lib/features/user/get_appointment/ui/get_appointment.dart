import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/user/get_appointment/bloc/get_appointment_bloc.dart';
import 'package:fontend/features/user/get_appointment/models/doctor_time_model.dart';
import 'package:fontend/utils/constants.dart';
import 'package:intl/intl.dart';

class GetAppointmentPage extends StatefulWidget {
  const GetAppointmentPage({super.key});

  @override
  State<GetAppointmentPage> createState() => _GetAppointmentPageState();
}

class _GetAppointmentPageState extends State<GetAppointmentPage> {
  final GetAppointmentBloc getAppointmentBloc = GetAppointmentBloc();

  @override
  void initState() {
    getAppointmentBloc.add(GetAppointmentInitialEvent());
    super.initState();
  }

  var selectedDeptID = "";
  var selectedDoctorID = "";
  var selectedSlot = "";
  var selectedIndex = -1;
  var consultationCharge = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAppointmentBloc, GetAppointmentState>(
      bloc: getAppointmentBloc,
      listenWhen: (previous, current) => current is GetAppointmentActionState,
      buildWhen: (previous, current) => current is! GetAppointmentActionState,
      listener: (context, state) {
        if (state is BookAppointmentErrorActionState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
            ),
          );
        }
        if (state is BookAppointmentSuccessActionState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Booked Successfully"),
              duration: Duration(seconds: 1),
            ),
          );
          Future.delayed(const Duration(milliseconds: 1500), () {
            Navigator.of(context).pop();
          });
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (GetAppointmentDataLoadingSuccessState):
            final successState = state as GetAppointmentDataLoadingSuccessState;

            return Scaffold(
              appBar: AppBar(
                title: const Text("Book Appointment"),
                iconTheme: appBarIcontheme,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: "Select Department",
                            filled: true,
                            fillColor: textFormFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 2,
                                color: appBarColor,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedDeptID = value!.deptID;
                            });
                          },
                          items: [
                            for (final dept in successState.deptModel)
                              DropdownMenuItem(
                                value: dept,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: textFormFieldColor,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(dept.deptName),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (selectedDeptID.isNotEmpty)
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: "Select Doctor",
                              filled: true,
                              fillColor: textFormFieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: appBarColor,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                consultationCharge = value!.consultationCharge;
                                selectedDoctorID = value.doctorID;
                              });
                            },
                            items: [
                              for (final doct in successState.doctorTimeModel)
                                if (selectedDeptID == doct.departmentID)
                                  DropdownMenuItem(
                                    value: doct,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 16,
                                          height: 16,
                                          color: textFormFieldColor,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(doct.doctorName),
                                      ],
                                    ),
                                  ),
                            ],
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (selectedDoctorID.isNotEmpty)
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: "Select Slot",
                              filled: true,
                              fillColor: textFormFieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: appBarColor,
                                ),
                              ),
                            ),
                            items: [
                              for (final doct in successState.doctorTimeModel)
                                if (doct.doctorID == selectedDoctorID)
                                  for (final timeModel in doct.timeArray)
                                    DropdownMenuItem(
                                      value: timeModel,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            color: timeModel.booked
                                                ? logOutButtonColor
                                                : textFormFieldColor,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            DateFormat('hh:mm a')
                                                .format(timeModel.startTime),
                                            style: TextStyle(
                                                color: timeModel.booked
                                                    ? logOutButtonColor
                                                    : Colors.black),
                                          ),
                                          SizedBox(
                                            width: 6,
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                  color: timeModel.booked
                                                      ? logOutButtonColor
                                                      : Colors.black),
                                            ),
                                          ),
                                          Text(
                                            DateFormat('hh:mm a')
                                                .format(timeModel.endTime),
                                            style: TextStyle(
                                                color: timeModel.booked
                                                    ? logOutButtonColor
                                                    : Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                if (value!.booked) {
                                  selectedIndex = -1;
                                  selectedSlot = "";
                                } else {
                                  selectedSlot =
                                      '${DateFormat('hh:mm a').format(value.startTime)} - ${DateFormat('hh:mm a').format(value.endTime)}';
                                  DoctorTimeModel selectedDoctor = successState
                                      .doctorTimeModel
                                      .firstWhere((doct) =>
                                          doct.doctorID == selectedDoctorID);
                                  selectedIndex = selectedDoctor.timeArray
                                      .indexWhere(
                                          (timeModel) => timeModel == value);
                                }
                              });
                            },
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (selectedSlot.isNotEmpty)
                          ElevatedButton(
                            onPressed: () {
                              getAppointmentBloc.add(
                                  BookAppointmentButtonClickedEvent(
                                      deptId: selectedDeptID,
                                      doctorId: selectedDoctorID,
                                      selectedSlot: selectedSlot,
                                      selectedIndex: selectedIndex));
                            },
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                iconButtonColor,
                              ),
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Book for Rs. $consultationCharge",
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          case const (GetAppointmentDataLoadingErrorState):
            final errorState = state as GetAppointmentDataLoadingErrorState;
            return Scaffold(
              body: Center(
                child: Text(
                  errorState.errorMessage,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );

          case const (GetAppointmentDataLoadingState):
            return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                color: iconButtonColor,
              )),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text(
                  "Something went wrong\n Try again later",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
        }
      },
    );
  }
}
