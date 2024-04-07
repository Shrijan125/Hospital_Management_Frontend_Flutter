import 'package:flutter/material.dart';
import 'package:fontend/features/auth/ui/splash.dart';
import 'package:fontend/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroudColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: appBarColor, titleTextStyle: appBartitleStyle),
      ),
      home: const Splash(),
    );
  }
}
