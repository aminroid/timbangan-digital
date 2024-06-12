import 'dart:io';
import 'package:scale_realtime/util/custom_alert.dart';
import 'package:scale_realtime/util/save_file_helper.dart';

import 'package:excel/excel.dart' as x;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:scale_realtime/core.dart';
import 'package:scale_realtime/util/data_shared_helper.dart';
import '../view/laporan_view.dart';

class LaporanController extends State<LaporanView> {
  static late LaporanController instance;
  late LaporanView view;
  final TextEditingController tanggalAwal = TextEditingController();
  DateTime? selectedTanggalAwal;
  final TextEditingController tanggalAkhir = TextEditingController();
  DateTime? selectedTanggalAkhir;

  List<DataRow> data = [];
  List<dynamic> dataPrint = [];
  String namaPengawas = "";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() async {
    tanggalAwal.text = tanggalAkhir.text = "dd-mm-yyyy";
    String? nama = await DataSharedPreferences().readString("nama");

    setState(() {
      namaPengawas = nama!;
    });
  }

  @override
  void dispose() {
    super.dispose();
    tanggalAwal.dispose();
  }

  void ubahTanggalAwal(DateTime newDate) {
    String dateStr = DateFormat('dd-MM-yyyy').format(newDate);
    setState(() {
      selectedTanggalAwal = newDate;
      tanggalAwal.text = dateStr;
      selectedTanggalAkhir = null;
      tanggalAkhir.text = 'dd-mm-yyyy';
    });
  }

  void ubahTanggalAkhir(DateTime newDate) {
    String dateStr = DateFormat('dd-MM-yyyy').format(newDate);
    setState(() {
      selectedTanggalAkhir = newDate;
      tanggalAkhir.text = dateStr;
    });
  }

  void pickDateAwal() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedTanggalAwal ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: biru,
              headerForegroundColor: Colors.white,
              backgroundColor: const Color(0xFFE6F3FD),
            ),
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
            primaryColor: biru,
            secondaryHeaderColor: biru,
            colorScheme: ColorScheme.light(primary: biru),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTanggalAwal) {
      ubahTanggalAwal(picked);
    }
  }

  void pickDateAkhir() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedTanggalAwal != null
          ? selectedTanggalAkhir ?? selectedTanggalAwal
          : selectedTanggalAkhir ?? DateTime.now(),
      firstDate: selectedTanggalAwal ?? DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: biru,
              headerForegroundColor: Colors.white,
              backgroundColor: const Color(0xFFE6F3FD),
            ),
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
            primaryColor: biru,
            secondaryHeaderColor: biru,
            colorScheme: ColorScheme.light(primary: biru),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTanggalAkhir) {
      ubahTanggalAkhir(picked);
      refreshData();
    }
  }

  void refreshData() async {
    setState(() {
      isLoading = true;
    });
    await Api.laporan(
            selectedTanggalAwal.toString(), selectedTanggalAkhir.toString())
        .then((value) async {
      try {
        if (!value.isEmpty) {
          List<DataRow> val = await DataTableHelper.formatData(value);
          setState(() {
            dataPrint = value;
            data = val;
          });
        } else {
          setState(() {
            data = [];
          });
        }
      } catch (e) {
        setState(() {
          data = [];
        });
        print(e.toString());
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  // Future<void> exportToExcel() async {
  //   // Create a new Excel document.
  //   final directory = await getApplicationSupportDirectory();
  //   String filePath = '${directory.path}/CreateExcel.xlsx';

  //   final Workbook workbook = new Workbook();
  //   //Accessing worksheet via index.
  //   workbook.worksheets[0];
  //   // Save the document.
  //   final List<int> bytes = workbook.saveAsStream();
  //   FileStorage.writeCounter(bytes, "CreateExcel.xlsx");
  //   // File(filePath).writeAsBytes(bytes);
  //   // print("succes");
  //   // print(filePath);
  //   //Dispose the workbook.

  //   workbook.dispose();
  // }

  Future<void> exportToExcel() async {
    x.Excel excel = x.Excel.createExcel();

    final border = x.Border(
        borderColorHex: x.ExcelColor.black, borderStyle: x.BorderStyle.Thin);

    var a1 = x.CellIndex.indexByString("A1");
    var b1 = x.CellIndex.indexByString("B1");
    excel.updateCell("Sheet1", a1, const x.TextCellValue("Pengawas :"));
    excel.updateCell("Sheet1", b1, x.TextCellValue(namaPengawas));

    var a2 = x.CellIndex.indexByString("A2");
    var b2 = x.CellIndex.indexByString("B2");
    excel.updateCell("Sheet1", a2, const x.TextCellValue(""));
    excel.updateCell("Sheet1", b2, const x.TextCellValue(""));

    var a3 = x.CellIndex.indexByString("A3");
    var b3 = x.CellIndex.indexByString("B3");
    excel.updateCell(
      "Sheet1",
      a3,
      const x.TextCellValue("Tanggal"),
      cellStyle: x.CellStyle()
        ..topBorder = border
        ..bottomBorder = border
        ..leftBorder = border
        ..rightBorder = border,
    );
    excel.updateCell(
      "Sheet1",
      b3,
      const x.TextCellValue("Berat (gram)"),
      cellStyle: x.CellStyle()
        ..topBorder = border
        ..bottomBorder = border
        ..leftBorder = border
        ..rightBorder = border,
    );

    // Menambahkan data
    int i = 3;
    for (var item in dataPrint) {
      final cell1 = x.CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i);
      final cell2 = x.CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i);

      excel.updateCell(
        "Sheet1",
        cell1,
        x.TextCellValue(item['tanggal']),
        cellStyle: x.CellStyle()
          ..topBorder = border
          ..bottomBorder = border
          ..leftBorder = border
          ..rightBorder = border,
      );
      excel.updateCell(
        "Sheet1",
        cell2,
        x.IntCellValue(item['berat']),
        cellStyle: x.CellStyle()
          ..topBorder = border
          ..bottomBorder = border
          ..leftBorder = border
          ..rightBorder = border,
      );

      i++;
    }

    await FileStorage.writeCounter(
        excel.encode()!, "hasil_timbangan_$namaPengawas.xlsx");

    Alert.succes(
        message:
            "File berhasil diexport pada dir Download/hasil_timbangan_$namaPengawas.xlsx",
        title: "Succes");
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
