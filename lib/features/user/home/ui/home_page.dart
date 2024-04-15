import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/user/home/bloc/home_bloc.dart';
import 'package:fontend/features/user/profile/ui/profile_page.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/navigation_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  @override
  void initState() {
    initSharedPrefs();
    super.initState();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  final homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is NavigateToUserProfileActionState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return UserProfilePage(
              prefs: prefs,
            );
          }));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          default:
            return Scaffold(
              appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(homePageTitle),
                      IconButton(
                        onPressed: () {
                          homeBloc.add(UserProfileButtonCLickedEvent());
                        },
                        icon: const Icon(
                          Icons.person,
                        ),
                      )
                    ],
                  ),
                  iconTheme: appBarIcontheme),
              drawer: const SideNavigationDrawer(),
            );
        }
      },
    );
  }
}
