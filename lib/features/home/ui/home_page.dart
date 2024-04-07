import 'package:flutter/material.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/navigation_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(homePageTitle),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      drawer: const SideNavigationDrawer(),
    );
  }
}
