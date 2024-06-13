import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scale_realtime/module/dashboard/controller/dashboard_controller.dart';

class TableTimbangan extends StatelessWidget {
  final DashboardController c;

  const TableTimbangan({
    super.key,
    required this.c,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (c.isLoading)
          Container(
            height: 350,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Color(0xFF63B0DF)),
            ),
          )
        else if (c.data.isEmpty)
          Container(
            height: 350,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "lib/assets/not_found.json",
                    width: 180,
                    height: 180,
                  ),
                  const Text("Data timbangan hari ini belum ada."),
                ],
              ),
            ),
          )
        else
          Container(
            height: 350,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: DataTable2(
                fixedColumnsColor: const Color.fromARGB(255, 218, 241, 255),
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) {
                    return const Color.fromARGB(
                        255, 218, 241, 255); // Default header color
                  },
                ),
                fixedLeftColumns: 1,
                columnSpacing: 10,
                horizontalMargin: 12,
                minWidth: MediaQuery.of(context).size.width + 20,
                columns: const [
                  // id, transDate, net, type
                  DataColumn2(
                    label: Text('No'),
                    fixedWidth: 30,
                  ),
                  DataColumn2(
                    label: Text('Tanggal'),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text('Berat (Gram)'),
                    // numeric: true,
                  ),
                ],
                rows: c.data,
              ),
            ),
          ),
      ],
    );
  }
}
