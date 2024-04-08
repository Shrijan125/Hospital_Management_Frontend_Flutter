import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fontend/features/auth/ui/splash.dart';
import 'package:fontend/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    refreshToken: prefs.getString('refreshToken'),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.refreshToken,
  });
  final String? refreshToken;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroudColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: appBarColor, titleTextStyle: appBartitleStyle),
      ),
      home: Splash(
        refreshToken: refreshToken,
      ),
    );
  }
}
