import 'package:excel/excel.dart' as x;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scale_realtime/core.dart';

class LaporanController extends State<LaporanView> {
  static late LaporanController instance;
  late LaporanView view;
  final TextEditingController tanggalAwal = TextEditingController();
  DateTime? selectedTanggalAwal;
  final TextEditingController tanggalAkhir = TextEditingController();
  DateTime? selectedTanggalAkhir;

  List<DataRow> data = [];
  List<dynamic> dataPrint = [];

  Map<String, List<Map<String, dynamic>>> groupedData = {};
  String? namaPengawas;
  String? namaTimbangan;
  bool showHint = true;

  bool isLoading = false;

  List<String> items = [];

  @override
  void initState() {
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() async {
    tanggalAwal.text = tanggalAkhir.text = "dd-mm-yyyy";
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
      tanggalAkhir.text = 'dd-mm-yyyy';
      namaPengawas = null;
      items = [];
      groupedData = {};
    });
  }

  void ubahTanggalAkhir(DateTime newDate) {
    String dateStr = DateFormat('dd-MM-yyyy').format(newDate);
    setState(() {
      selectedTanggalAkhir = newDate;
      tanggalAkhir.text = dateStr;
      namaPengawas = null;
      items = [];
      groupedData = {};
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
          filterData(value);
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

  void filterData(dynamic newValue) {
    Set<String> pengawasSet = {};

    for (var item in newValue) {
      String namaPengawas = item['namaPengawas'];
      pengawasSet.add(namaPengawas);

      if (!groupedData.containsKey(namaPengawas)) {
        groupedData[namaPengawas] = [];
      }
      groupedData[namaPengawas]!.add(item);
    }

    setState(() {
      items = pengawasSet.toList();
    });
  }

  void changeNamaPengawas(String newValue) async {
    List<DataRow> val =
        await DataTableHelper.formatData(groupedData[newValue]!);

    setState(() {
      namaPengawas = newValue;
      namaTimbangan = groupedData[newValue]!.first["namaTimbangan"];
      dataPrint = groupedData[newValue]!;
      data = val;
    });
  }

  Future<void> exportToExcel() async {
    x.Excel excel = x.Excel.createExcel();

    final border = x.Border(
        borderColorHex: x.ExcelColor.black, borderStyle: x.BorderStyle.Thin);

    var a1 = x.CellIndex.indexByString("A1");
    var b1 = x.CellIndex.indexByString("B1");
    excel.updateCell("Sheet1", a1, const x.TextCellValue("Timbangan :"));
    excel.updateCell("Sheet1", b1, x.TextCellValue(namaTimbangan!));

    var a2 = x.CellIndex.indexByString("A2");
    var b2 = x.CellIndex.indexByString("B2");
    excel.updateCell("Sheet1", a2, const x.TextCellValue("Pengawas :"));
    excel.updateCell("Sheet1", b2, x.TextCellValue(namaPengawas!));

    var a3 = x.CellIndex.indexByString("A3");
    var b3 = x.CellIndex.indexByString("B3");
    excel.updateCell("Sheet1", a3, const x.TextCellValue(""));
    excel.updateCell("Sheet1", b3, const x.TextCellValue(""));

    var a4 = x.CellIndex.indexByString("A4");
    var b4 = x.CellIndex.indexByString("B4");
    excel.updateCell(
      "Sheet1",
      a4,
      const x.TextCellValue("Tanggal"),
      cellStyle: x.CellStyle()
        ..topBorder = border
        ..bottomBorder = border
        ..leftBorder = border
        ..rightBorder = border,
    );
    excel.updateCell(
      "Sheet1",
      b4,
      const x.TextCellValue("Berat (gram)"),
      cellStyle: x.CellStyle()
        ..topBorder = border
        ..bottomBorder = border
        ..leftBorder = border
        ..rightBorder = border,
    );

    // Menambahkan data
    int i = 4;
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
