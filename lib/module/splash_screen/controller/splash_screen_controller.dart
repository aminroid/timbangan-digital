import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:scale_realtime/core.dart';

class SplashScreenController extends State<SplashScreenView> {
  static late SplashScreenController instance;
  late SplashScreenView view;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      getx.Get.offAll(const LoginView());
    });
    instance = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
