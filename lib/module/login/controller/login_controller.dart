import 'package:flutter/material.dart';
import 'package:scale_realtime/core.dart';
import 'package:get/get.dart' as getx;
import '../view/login_view.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool passwordVisible = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  void setPasswordVisible(bool newValue) {
    setState(() {
      passwordVisible = newValue;
    });
  }

  void onPressedAction() {
    getx.Get.snackbar("Alert", "Username dan password tidak boleh kosong.");
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
