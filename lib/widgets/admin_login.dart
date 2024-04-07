import 'package:flutter/material.dart';
import 'package:fontend/features/auth/bloc/authentication_bloc.dart';
import 'package:fontend/functions/null_checker.dart';
import 'package:fontend/utils/constants.dart';

class LoginAdminWidget extends StatelessWidget {
  LoginAdminWidget({super.key, required this.authenticationBloc});

  final AuthenticationBloc authenticationBloc;

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          hintText: "Admin ID",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            authenticationBloc
                                .add(AdminLoginButtonPressedEvent());
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
                              "Login",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            authenticationBloc.add(UserButtonPressedEvent());
                          },
                          child: const Text(
                            "User",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
