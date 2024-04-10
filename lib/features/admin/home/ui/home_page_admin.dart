import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontend/features/admin/add_doctor/ui/add_doctor.dart';
import 'package:fontend/features/admin/add_department/ui/add_department.dart';
import 'package:fontend/features/admin/home/bloc/admin_home_bloc.dart';
import 'package:fontend/features/auth/ui/auth.dart';
import 'package:fontend/utils/constants.dart';
import 'package:fontend/widgets/list_tile_admin_home.dart';

class HomePageAdmin extends StatelessWidget {
  HomePageAdmin({super.key});
  final AdminHomeBloc adminHomeBloc = AdminHomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminHomeBloc, AdminHomeState>(
      bloc: adminHomeBloc,
      listenWhen: (previous, current) => current is AdminHomeActionState,
      buildWhen: (previous, current) => current is! AdminHomeActionState,
      listener: (context, state) {
        if (state is AdminLogoutActionState) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const LoginScreen();
          }));
        }
        if (state is AddDepartmentActionState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return const AddDepartment();
          }));
        }
        if (state is AddDoctorActionState) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return const AddDoctor();
          }));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Welcome Admin"),
                IconButton(
                  onPressed: () {
                    adminHomeBloc.add(AdminLogoutButtonCLickedEvent());
                  },
                  icon: const Icon(
                    Icons.logout,
                  ),
                )
              ],
            ),
            iconTheme: appBarIcontheme,
          ),
          body: ListView(
            children: [
              ListTileAdminHome(
                title: "Add Doctor",
                icon: Icons.person_add,
                adminHomeBloc: adminHomeBloc,
                event: AddDoctorButtonClickedEvent(),
              ),
              const Divider(),
              ListTileAdminHome(
                  title: "Add Department",
                  icon: Icons.add,
                  adminHomeBloc: adminHomeBloc,
                  event: AddDepartmentButtonClickedEvent()),
              const Divider()
            ],
          ),
        );
      },
    );
  }
}
