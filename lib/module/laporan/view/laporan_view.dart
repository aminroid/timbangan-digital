import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scale_realtime/core.dart';

class LaporanView extends StatefulWidget {
  const LaporanView({Key? key}) : super(key: key);

  Widget build(context, LaporanController controller) {
    controller.view = this;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Laporan",
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
                      onTap: () => controller.selectedTanggalAwal != null
                          ? controller.pickDateAkhir()
                          : (),
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
                height: 20.0,
              ),
              Row(
                children: [
                  Text(
                    "Pengawas       ",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 0, 21, 61),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: DropdownButton(
                          value: controller.namaPengawas,
                          borderRadius: BorderRadius.circular(16),
                          iconEnabledColor: Colors.black,
                          hint: const Text(
                            "nama pengawas",
                            style: TextStyle(
                                color: Color(0xFF1C1B1F),
                                fontWeight: FontWeight.w400),
                          ),
                          dropdownColor: Colors.white,
                          focusColor: Colors.white,
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                            right: 4,
                          ),
                          underline: const SizedBox(),
                          isDense: true,
                          isExpanded: true,
                          onChanged: (String? value) {
                            controller.changeNamaPengawas(value!);
                          },
                          items: controller.items
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
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
      floatingActionButton: controller.data.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                controller.exportToExcel();
              },
              splashColor: biru,
              backgroundColor: const Color(0XFF98D4F6),
              child: const Icon(Icons.print),
            )
          : null,
    );
  }

  @override
  State<LaporanView> createState() => LaporanController();
}
