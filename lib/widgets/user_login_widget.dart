import 'package:flutter/material.dart';
import 'package:fontend/features/auth/bloc/authentication_bloc.dart';
import 'package:fontend/functions/null_checker.dart';
import 'package:fontend/utils/constants.dart';

class LoginUserWidget extends StatelessWidget {
  LoginUserWidget({super.key, required this.authenticationBloc});

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
                            authenticationBloc.add(UserLoginButtonPressedEvent(
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
                            authenticationBloc.add(AdminButtonPressedEvent());
                          },
                          child: const Text(
                            "Admin?",
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
                    TextButton(
                      onPressed: () {
                        authenticationBloc
                            .add(DontHaveAccountButtonPressedEvent());
                      },
                      child: const Text(
                        "Don't have an account? Sign up!",
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
    );
  }
}

//  int adminState = 1;
//   final _formKey = GlobalKey<FormState>();

//   int loginState = 1;

//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordcontroller = TextEditingController();

//   void clearFormField() {
//     _usernameController.clear();
//     _emailController.clear();
//     _passwordcontroller.clear();
//   }

  // bool nullEmptyValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }


// return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//           width: double.infinity,
//           height: 400,
//           decoration: BoxDecoration(
//             color: backgroudColor,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         if (loginState == 0)
//                           TextFormField(
//                             cursorColor: appBarColor,
//                             controller: _emailController,
//                             autocorrect: false,
//                             keyboardType: TextInputType.emailAddress,
//                             validator: (value) {
//                               if (nullEmptyValidator(value)) {
//                                 return "Email can't be empty";
//                               } else {
//                                 if (value!.contains("@") &&
//                                     value.contains(".com")) {
//                                   return null;
//                                 } else {
//                                   return "Please enter a valid email";
//                                 }
//                               }
//                             },
//                             decoration: InputDecoration(
//                               fillColor: textFormFieldColor,
//                               filled: true,
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                                 borderSide: const BorderSide(
//                                   width: 2,
//                                   color: appBarColor,
//                                 ),
//                               ),
//                               hintText: "Email",
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                             ),
//                           ),
//                         if (loginState == 0)
//                           const SizedBox(
//                             height: 20,
//                           ),
//                         TextFormField(
//                           cursorColor: appBarColor,
//                           controller: _usernameController,
//                           validator: (value) {
//                             if (nullEmptyValidator(value)) {
//                               return "Username can't be empty";
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(
//                               fillColor: textFormFieldColor,
//                               filled: true,
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                                 borderSide: const BorderSide(
//                                   width: 2,
//                                   color: appBarColor,
//                                 ),
//                               ),
//                               hintText: loginState == 1
//                                   ? (adminState == 1 ? "Admin ID" : "Username")
//                                   : "Username",
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20))),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           cursorColor: appBarColor,
//                           controller: _passwordcontroller,
//                           validator: (value) {
//                             if (nullEmptyValidator(value)) {
//                               return "Password can't be empty";
//                             }
//                             if (loginState == 0 && value!.length < 8) {
//                               return "Password must be 8 characters long";
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(
//                             fillColor: textFormFieldColor,
//                             filled: true,
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                 width: 2,
//                                 color: appBarColor,
//                               ),
//                             ),
//                             hintText: "Password",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20)),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () {},
//                               style: const ButtonStyle(
//                                 backgroundColor: MaterialStatePropertyAll(
//                                   iconButtonColor,
//                                 ),
//                                 foregroundColor:
//                                     MaterialStatePropertyAll(Colors.white),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Text(
//                                   loginState == 1 ? "Login" : "Sign Up",
//                                   style: const TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             if (loginState == 1)
//                               TextButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       _formKey.currentState!.reset();
//                                       clearFormField();
//                                       adminState == 1
//                                           ? adminState = 0
//                                           : adminState = 1;
//                                     });
//                                   },
//                                   child: Text(
//                                     adminState == 1 ? "User?" : "Admin?",
//                                     style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                                   ))
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             setState(() {
//                               _formKey.currentState!.reset();
//                               clearFormField();
//                               loginState == 1 ? loginState = 0 : loginState = 1;
//                             });
//                           },
//                           child: Text(
//                             loginState == 1
//                                 ? "Don't have an account? Sign up!"
//                                 : "Already have an account? Login.",
//                             style: const TextStyle(
//                                 fontSize: 18, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );