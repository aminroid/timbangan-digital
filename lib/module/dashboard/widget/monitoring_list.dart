import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonitoringList extends StatelessWidget {
  final String namaData;
  final String val;
  final IconData icon;
  final String satuan;

  const MonitoringList({
    super.key,
    required this.namaData,
    required this.val,
    required this.icon,
    required this.satuan,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    child: Icon(
                      icon,
                      color: const Color.fromARGB(255, 51, 84, 145),
                    ),
                  ),
                  Text(
                    namaData,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 0, 21, 61),
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: val,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: const Color.fromARGB(255, 0, 21, 61),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " $satuan",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color.fromARGB(255, 0, 21, 61),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
