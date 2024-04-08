import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/auth/bloc/authentication_bloc.dart';
import 'package:fontend/features/user/home/ui/home_page.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/admin_login.dart';
import 'package:fontend/widgets/user_login_widget.dart';
import 'package:fontend/widgets/user_sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences prefs;
  @override
  void initState() {
    initSharedPref();
    super.initState();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  final AuthenticationBloc authenticationBloc = AuthenticationBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      listenWhen: (previous, current) => current is AuthenticationActionState,
      buildWhen: (previous, current) => current is! AuthenticationActionState,
      listener: (context, state) async {
        if (state is UserLoggedInActionState) {
          await prefs.setString('refreshToken', state.refreshToken);
          await prefs.setString('accessToken', state.accessToken);
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return HomePage();
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
