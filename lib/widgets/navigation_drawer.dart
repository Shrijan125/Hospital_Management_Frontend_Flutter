import 'package:flutter/material.dart';
import 'package:fontend/utils/constants.dart';

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
                    margin: EdgeInsets.only(left: 10),
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
        ],
      ),
    );
  }
}
