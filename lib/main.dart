import 'package:flutter/material.dart';
import 'package:fontend/features/user/appointments/ui/user_appointment.dart';
import 'package:fontend/features/user/bills/user_bill.dart';
import 'package:fontend/features/user/contact_us/user_contact.dart';
import 'package:fontend/features/user/lab_reports/user_lab_report.dart';
import 'package:fontend/features/user/order_medicine/user_order_medicine.dart';
import 'package:fontend/features/user/our_doctors/user_our_doctors.dart';
import 'package:fontend/features/user/prescriptions/user_prescriptions.dart';
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
      routes: {
        '/user_appointment': (context) => const UserAppointmentPage(),
        '/order_medicine': (context) => const UserOrderMedicinePage(),
        '/user_bill': (context) => const UserBillPage(),
        '/user_lab_reports': (context) => const UserLabReport(),
        '/our_doctors': (context) => const UserOurDoctors(),
        '/contact_us': (context) => const UserContactPage(),
        '/prescritions': (context) => const UserPrescriptionsPage()
      },
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
