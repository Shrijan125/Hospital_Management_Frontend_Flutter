import 'package:flutter/material.dart';
import 'package:fontend/features/auth/ui/auth.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/navigator_drawer_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideNavigationDrawer extends StatelessWidget {
  const SideNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroudColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: const Image(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/logo_cropped.png'),
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 15,
                // ),
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "HealthCare",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      Text(
                        "Clinic",
                        style: TextStyle(
                            color: iconButtonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const DrawerItem(
            title: "Order Medicine",
            icon: Icons.shopping_bag,
            destination: '/order_medicine',
          ),
          const Divider(),
          const DrawerItem(
            title: "Appointments",
            icon: Icons.event,
            destination: '/user_appointment',
          ),
          const Divider(),
          const DrawerItem(
            title: "Bills",
            icon: Icons.receipt,
            destination: '/user_bill',
          ),
          const Divider(),
          const DrawerItem(
            title: "Lab Reports",
            icon: Icons.description,
            destination: '/user_lab_reports',
          ),
          const Divider(),
          const DrawerItem(
            title: "Prescriptions",
            icon: Icons.document_scanner,
            destination: '/prescritions',
          ),
          const Divider(),
          const DrawerItem(
            title: "Our Doctors",
            icon: Icons.person_3_rounded,
            destination: '/our_doctors',
          ),
          const Divider(),
          const DrawerItem(
            title: "Contact Us",
            icon: Icons.contact_emergency,
            destination: '/contact_us',
          ),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('accessToken');
              await prefs.remove('refreshToken');
              if (context.mounted) {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const LoginScreen();
                }));
              }
            },
            leading: const Icon(
              Icons.logout,
              color: logOutButtonColor,
              size: 30,
            ),
            title: const Text(
              "Log Out",
              style: TextStyle(
                  color: logOutButtonColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
