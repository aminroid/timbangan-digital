import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scale_realtime/core.dart';
import 'package:lottie/lottie.dart';

class TableLaporan extends StatelessWidget {
  final LaporanController c;

  const TableLaporan({
    super.key,
    required this.c,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (c.data.isEmpty)
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
                  Text("Data tidak ditemukan."),
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
