import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scale_realtime/core.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  Widget build(context, DashboardController controller) {
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
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Tulisan Monitoring
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingMain),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Data Monitoring ",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 0, 21, 61),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    controller.isOn ? Icons.circle : Icons.circle,
                    color: controller.isOn ? Colors.green : Colors.red,
                    size: 8,
                  ),
                ],
              ),
            ),

            // Tampilan Monitoring
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              itemCount: controller.listData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2),
              ),
              itemBuilder: (context, index) {
                return MonitoringList(
                  icon: controller.listData[index][0],
                  namaData: controller.listData[index][1],
                  val: index == 0
                      ? controller.dataRealtime
                      : controller.dataJumlah,
                  satuan: controller.listData[index][2],
                );
              },
            ),

            const SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingMain),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "History Data Hari Ini",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 0, 21, 61),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TableTimbangan(c: controller)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  State<DashboardView> createState() => DashboardController();
}
