import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fontend/features/auth/ui/auth.dart';
import 'package:fontend/features/user/edit_profile/ui/edit_profile.dart';
import 'package:fontend/features/user/profile/bloc/profile_bloc.dart';
import 'package:fontend/utils/constants.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    super.key,
    required this.prefs,
  });
  final SharedPreferences prefs;
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final profileBloc = ProfileBloc();

  @override
  Widget build(BuildContext context) {
    var decodedToken =
        JwtDecoder.decode(widget.prefs.getString('accessToken')!);

    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listenWhen: (previous, current) => current is ProfileActionState,
      buildWhen: (previous, current) => current is! ProfileActionState,
      listener: (context, state) async {
        if (state is NavigateToEditProfileActionState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return EditProfilePage(
              email: decodedToken['email'],
            );
          }));
        }
        if (state is LogoutActionState) {
          await widget.prefs.remove('accessToken');
          await widget.prefs.remove('refreshToken');
          if (context.mounted) {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return const LoginScreen();
            }));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(profiePageTitle),
            iconTheme: appBarIcontheme,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  decodedToken['username'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Text(
                  decodedToken['email'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    profileBloc.add(EditProfileButtonCLickedEvent());
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      iconButtonColor,
                    ),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Edit Profile",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      profileBloc.add(LogoutButtonCLickedEvent());
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: logOutButtonColor,
                          size: 30,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(
                              color: logOutButtonColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
