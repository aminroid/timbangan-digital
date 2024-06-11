import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as getx;
import 'package:scale_realtime/core.dart';

class SplashScreenController extends State<SplashScreenView> {
  static late SplashScreenController instance;
  late SplashScreenView view;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: biru,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: biru,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    Future.delayed(const Duration(seconds: 1)).then((value) {
      getx.Get.offAll(const LoginView());
    });
    instance = this;
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: putih,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
