import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scale_realtime/core.dart';
import '../view/laporan_view.dart';

class LaporanController extends State<LaporanView> {
  static late LaporanController instance;
  late LaporanView view;
  final TextEditingController tanggalAwal = TextEditingController();
  DateTime? selectedTanggalAwal;
  final TextEditingController tanggalAkhir = TextEditingController();
  DateTime? selectedTanggalAkhir;

  List<DataRow> data = [];

  @override
  void initState() {
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {
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
      tanggalAkhir.text = '';
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
              backgroundColor: Color(0xFFE6F3FD),
            ),
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
            primaryColor: biru,
            secondaryHeaderColor: biru,
            colorScheme: ColorScheme.light(primary: biru),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
          ? selectedTanggalAwal
          : selectedTanggalAkhir ?? DateTime.now(),
      firstDate: selectedTanggalAwal ?? DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: biru,
              headerForegroundColor: Colors.white,
              backgroundColor: Color(0xFFE6F3FD),
            ),
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
            primaryColor: biru,
            secondaryHeaderColor: biru,
            colorScheme: ColorScheme.light(primary: biru),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTanggalAkhir) {
      ubahTanggalAkhir(picked);
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
