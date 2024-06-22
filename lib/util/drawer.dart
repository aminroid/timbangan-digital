// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scale_realtime/module/dashboard/view/dashboard_view.dart';
import 'package:scale_realtime/module/laporan/view/laporan_view.dart';
import 'package:scale_realtime/module/login/view/login_view.dart';
import 'package:scale_realtime/util/custom_const.dart';
import 'package:scale_realtime/util/data_shared_helper.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  bool isAdmin = false;
  @override
  void initState() {
    super.initState();
    setAdmin();
  }

  void setAdmin() async {
    String? role = await DataSharedPreferences().readString("role");
    setState(() {
      isAdmin = role == "admin";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  biruHalus,
                  biru,
                ],
                center: const Alignment(0.0, 0.0),
                radius: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/assets/logo.png",
                  width: 65,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Timbangan Digital",
                  style: GoogleFonts.inter(
                      color: Colors.white, decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Monitoring'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) => const DashboardView(),
                ),
              );
            },
          ),
          if (isAdmin)
            ListTile(
              leading: const Icon(Icons.file_copy_rounded),
              title: const Text('Laporan'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (context) => const LaporanView(),
                  ),
                );
              },
            ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Laporan'),
            onTap: () {
              DataSharedPreferences().clearData();
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) => const LoginView(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
