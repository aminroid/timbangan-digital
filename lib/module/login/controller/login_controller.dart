import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scale_realtime/core.dart';
import 'package:get/get.dart' as getx;

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

  void onPressedAction() async {
    setState(() {
      isLoading = !isLoading;
    });
    if (username.text.isEmpty || password.text.isEmpty) {
      Alert.warning(
        title: "Alert",
        message: "Username atau password tidak boleh kosong.",
      );
      setState(() {
        isLoading = !isLoading;
      });
    } else {
      await Api.login(username.text, password.text).then((value) {
        try {
          if (value.isEmpty) {
            Alert.warning(
              title: "Alert",
              message: "Username dan password salah.",
            );
          } else {
            String role = value.first['role'] == 0 ? "admin" : "pengawas";
            DataSharedPreferences().saveString("role", role);

            getx.Get.offAll(const DashboardView());
          }
        } catch (e) {
          print(e.toString());
          Alert.warning(
            title: "Alert",
            message: e.toString(),
          );
        }
        setState(() {
          isLoading = !isLoading;
        });
      });
    }
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
