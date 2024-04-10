import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/user/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:fontend/features/user/profile/ui/profile_page.dart';

import 'package:fontend/functions/null_checker.dart';
import 'package:fontend/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _oldpasswordController = TextEditingController();
  final _newpasswordController = TextEditingController();
  @override
  void initState() {
    _emailController.text = widget.email;
    super.initState();
  }

  final EditProfileBloc editProfileBloc = EditProfileBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      bloc: editProfileBloc,
      listenWhen: (previous, current) => current is EditProfileActionState,
      buildWhen: (previous, current) => current is! EditProfileActionState,
      listener: (context, state) async {
        if (state is ChangesSavedActionState) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', state.accessToken);
          await prefs.setString('refreshToken', state.refreshToken);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Changes saved'),
              duration: Duration(seconds: 1),
            ),
          );

          Future.delayed(const Duration(milliseconds: 1500), () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return UserProfilePage(prefs: prefs);
            }));
          });
        }
        if (state is ErrorActionState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(editProfilePageTitle),
            iconTheme: appBarIcontheme,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/logo_cropped.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
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
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          cursorColor: appBarColor,
                          controller: _oldpasswordController,
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
                            hintText: "Old Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          cursorColor: appBarColor,
                          controller: _newpasswordController,
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
                            hintText: "New Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            editProfileBloc.add(
                              SaveChangesButtonClickedEvent(
                                  oldPassword: _oldpasswordController.text,
                                  newPassword: _newpasswordController.text,
                                  email: _emailController.text),
                            );
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
                            child: state.runtimeType == SavingChangesState
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : state.runtimeType == ErrorState
                                    ? const Text(
                                        "Save Changes",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const Text(
                                        "Save Changes",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
