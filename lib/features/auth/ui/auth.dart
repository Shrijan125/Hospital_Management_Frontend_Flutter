import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/auth/bloc/authentication_bloc.dart';
import 'package:fontend/features/home/ui/home_page.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/admin_login.dart';
import 'package:fontend/widgets/user_login_widget.dart';
import 'package:fontend/widgets/user_sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationBloc authenticationBloc = AuthenticationBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      listenWhen: (previous, current) => current is AuthenticationActionState,
      buildWhen: (previous, current) => current is! AuthenticationActionState,
      listener: (context, state) {
        if (state is UserLoggedInActionState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return const HomePage();
          }));
        }
        if (state is UserLoginErrorActionState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (UserLoginState):
            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: backgroudColor),
                child: Center(
                    child: LoginUserWidget(
                        authenticationBloc: authenticationBloc)),
              ),
            );
          case const (UserSignupState):
            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: backgroudColor),
                child: Center(
                  child:
                      UserSignUpWidget(authenticationBloc: authenticationBloc),
                ),
              ),
            );

          case const (AdminLoginState):
            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: backgroudColor),
                child: Center(
                  child: LoginAdminWidget(
                    authenticationBloc: authenticationBloc,
                  ),
                ),
              ),
            );

          default:
            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: backgroudColor),
                child: Center(
                    child: LoginUserWidget(
                        authenticationBloc: authenticationBloc)),
              ),
            );
        }
      },
    );
  }
}
