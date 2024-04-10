import 'package:flutter/material.dart';
import 'package:fontend/features/admin/home/bloc/admin_home_bloc.dart';

class ListTileAdminHome extends StatelessWidget {
  const ListTileAdminHome(
      {super.key,
      required this.title,
      required this.icon,
      required this.adminHomeBloc,
      required this.event});
  final AdminHomeBloc adminHomeBloc;
  final AdminHomeEvent event;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          adminHomeBloc.add(event);
        },
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 60,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )
            ],
          ),
        ));
  }
}


// ListTile(
//       onTap: () {},
//       leading: Icon(
//         icon,
//         color: Colors.white,
//         size: 30,
//       ),
//       title: Text(title),
//     );