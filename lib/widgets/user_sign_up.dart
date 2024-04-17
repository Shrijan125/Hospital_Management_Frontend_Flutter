import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/auth/bloc/authentication_bloc.dart';
import 'package:fontend/functions/null_checker.dart';
import 'package:fontend/utils/constants.dart';

class UserSignUpWidget extends StatelessWidget {
  UserSignUpWidget({
    super.key,
    required this.authenticationBloc,
  });
  final AuthenticationBloc authenticationBloc;

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      listenWhen: (previous, current) => current is AuthenticationActionState,
      listener: (context, state) {
        if (state is UserSignUpErrorActionState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
            ),
          );
        }
        if (state is UserSignedUpActionState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Sign Up Successful. Try Logging in."),
              duration: Duration(seconds: 1),
            ),
          );
          Future.delayed(const Duration(milliseconds: 1500), () {
            authenticationBloc.add(AlreadyHaveAccountButtonPressedEvent());
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          color: backgroudColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: appBarColor,
                        controller: _emailController,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (nullEmptyValidator(value)) {
                            return "Email can't be empty";
                          } else {
                            if (value!.contains("@") &&
                                value.contains(".com")) {
                              return null;
                            } else {
                              return "Please enter a valid email";
                            }
                          }
                        },
                        decoration: InputDecoration(
                          fillColor: textFormFieldColor,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: appBarColor,
                            ),
                          ),
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        cursorColor: appBarColor,
                        controller: _usernameController,
                        validator: (value) {
                          if (nullEmptyValidator(value)) {
                            return "Username can't be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: textFormFieldColor,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 2,
                                color: appBarColor,
                              ),
                            ),
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        cursorColor: appBarColor,
                        controller: _passwordcontroller,
                        validator: (value) {
                          if (nullEmptyValidator(value)) {
                            return "Password can't be empty";
                          }
                          if (value!.length < 8) {
                            return "Password must be 8 characters long";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: textFormFieldColor,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: appBarColor,
                            ),
                          ),
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          authenticationBloc.add(SignUpButtonPressedEvent(
                              email: _emailController.text,
                              username: _usernameController.text,
                              password: _passwordcontroller.text));
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            iconButtonColor,
                          ),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          authenticationBloc
                              .add(AlreadyHaveAccountButtonPressedEvent());
                        },
                        child: const Text(
                          "Already have an account? Login.",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
