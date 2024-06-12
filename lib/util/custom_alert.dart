// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;

class Alert {
  static Future<void> succes({title, message}) async {
    getx.Get.snackbar(
      "",
      "",
      titleText: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            width: 4,
          ),
          const Icon(
            Icons.check_rounded,
            size: 24,
            color: Color(0XFF32c156),
          )
        ],
      ),
      messageText: Text(message),
    );
  }

  static Future<void> warning({title, message}) async {
    getx.Get.snackbar(
      "",
      "",
      titleText: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            width: 4,
          ),
          const Icon(
            Icons.warning_rounded,
            size: 24,
            color: Color(0XFFe63a38),
          )
        ],
      ),
      messageText: Text(message),
    );
  }
}
