import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataTableHelper {
  static changeFormatDate(String value) {
    DateTime format = DateTime.parse(value);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(format);
    return (formattedDate);
  }

  static Future<List<DataRow>> formatData(
      List<Map<String, dynamic>> value) async {
    List<dynamic>? jsonData;

    var dapat = jsonEncode(value);
    jsonData = jsonDecode(dapat);

    jsonData?.sort((a, b) => b['date'].compareTo(a['date']));

    List<DataRow> dataRows = [];
    bool rowPertama = true;
    int no = 1;
    if (jsonData != null) {
      for (var item in jsonData) {
        String date = item['date'];
        String nilai = item['weight'];

        dataRows.add(DataRow(
          color: rowPertama
              ? MaterialStateProperty.all(
                  const Color.fromARGB(255, 176, 255, 179))
              : MaterialStateProperty.all(Colors.white),
          cells: [
            DataCell(Text(no.toString())),
            DataCell(Text(date)),
            DataCell(Text(nilai)),
          ],
        ));

        no++;
        rowPertama = false;
      }
      return dataRows;
    } else {
      return [];
    }
  }
}
