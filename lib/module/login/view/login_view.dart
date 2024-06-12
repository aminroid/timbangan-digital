import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scale_realtime/core.dart';
import 'package:scale_realtime/util/custom_button.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        toolbarHeight: 0,
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_open_rounded,
                  size: 82,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Welcome",
                  style: GoogleFonts.poppins(
                    color: hitam,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Login kedalam sistem monitoring timbangan digital",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: hitam, fontSize: 14),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                TextField(
                  controller: controller.username,
                  autofocus: false,
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    label: Text(
                      "Masukan username di sini",
                      style: TextStyle(color: Color.fromARGB(129, 0, 0, 0)),
                    ),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: controller.password,
                  obscureText: !controller.passwordVisible,
                  autofocus: false,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: Colors.white,
                    label: const Text(
                      "Masukan username di sini",
                      style: TextStyle(color: Color.fromARGB(129, 0, 0, 0)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.passwordVisible
                            ? CupertinoIcons.eye_fill
                            : CupertinoIcons.eye_slash_fill,
                        color: Colors.black,
                      ),
                      onPressed: () => controller
                          .setPasswordVisible(!controller.passwordVisible),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                CustomButton(
                    title: "Login",
                    isLoading: controller.isLoading,
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            controller.onPressedAction();
                          }),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
