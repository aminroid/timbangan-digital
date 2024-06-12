import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scale_realtime/module/splash_screen/widget/loading_animation.dart';
import 'package:scale_realtime/util/custom_const.dart';
import '../controller/splash_screen_controller.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  Widget build(context, SplashScreenController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        actions: const [],
        backgroundColor: biru,
        toolbarHeight: 0,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                biruHalus,
                biru,
              ],
              center: const Alignment(0.0, 0.0),
              radius: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "lib/assets/logo.png",
                width: 80,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Timbangan Digital",
                style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const DotLoadingAnimation(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<SplashScreenView> createState() => SplashScreenController();
}
