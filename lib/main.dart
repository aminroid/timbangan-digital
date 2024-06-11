import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scale_realtime/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(),
    ),
  );
}
