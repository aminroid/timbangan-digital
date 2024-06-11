import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scale_realtime/core.dart';
import 'package:scale_realtime/module/laporan/widget/table_laporan.dart';
import '../controller/laporan_controller.dart';

class LaporanView extends StatefulWidget {
  const LaporanView({Key? key}) : super(key: key);

  Widget build(context, LaporanController controller) {
    controller.view = this;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Monitoring",
          style: GoogleFonts.poppins(
            color: hitam,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      drawer: Drawer(
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Tanggal Awal",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 0, 21, 61),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: controller.tanggalAwal,
                      onTap: () => controller.pickDateAwal(),
                      autocorrect: false,
                      readOnly: true,
                      autofocus: false,
                      enableInteractiveSelection: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Text(
                    "Tanggal Akhir",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 0, 21, 61),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: controller.tanggalAkhir,
                      onTap: () => controller.pickDateAkhir(),
                      autocorrect: false,
                      readOnly: true,
                      autofocus: false,
                      enableInteractiveSelection: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.white,
                        counterText: '',
                        labelText: 'dd-mm-yyyy',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              TableLaporan(c: controller)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        splashColor: Color.fromARGB(255, 180, 249, 195),
        backgroundColor: const Color(0xFF88EB9E),
        child: Icon(Icons.print),
      ),
    );
  }

  @override
  State<LaporanView> createState() => LaporanController();
}
