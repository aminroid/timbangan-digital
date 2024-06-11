import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scale_realtime/util/custom_const.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.title,
      this.isLoading = false,
      this.large = true,
      this.color = const Color(0xFF63B0DF),
      this.onPressed})
      : super(key: key);

  final String title;
  final bool isLoading;
  final VoidCallback? onPressed;
  final bool large;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(
              vertical: large ? 24 : 16, horizontal: large ? 24 * 2 : 16),
          foregroundColor: putih,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: isLoading
            ? Container(
                width: large ? 24 : 20,
                height: large ? 24 : 20,
                padding: const EdgeInsets.all(2.0),
                child: const CircularProgressIndicator(
                  color: Color(0xFF63B0DF),
                  strokeWidth: 3,
                ),
              )
            : const SizedBox.shrink(),
        label: Text(
          "$title  ",
          style: GoogleFonts.poppins(
              fontSize: large ? 18 : 12,
              fontWeight: large ? FontWeight.normal : FontWeight.w600),
        ),
      ),
    );
  }
}
