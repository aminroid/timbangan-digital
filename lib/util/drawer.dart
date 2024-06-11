// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scale_realtime/module/dashboard/view/dashboard_view.dart';
import 'package:scale_realtime/module/laporan/view/laporan_view.dart';
import 'package:scale_realtime/util/custom_const.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

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
        ],
      ),
    );
  }
}
