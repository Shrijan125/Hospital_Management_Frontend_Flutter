part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

abstract class HomeActionState extends HomeState {}

class NavigateToUserProfileActionState extends HomeActionState {}

class HomeDoctorLoadingState extends HomeState {}

class HomeDoctorLoadingSuccessState extends HomeState {
  final List<DoctorModel> doctorModel;

  HomeDoctorLoadingSuccessState({required this.doctorModel});
}

class HomeDoctorLoadingErrorState extends HomeState {}
