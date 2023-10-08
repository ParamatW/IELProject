// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ielproject/utility/app_constant.dart';

class AppSnackBar {
  final String title;
  final String message;
  AppSnackBar({
    required this.title,
    required this.message,
  });

  // AppSnackBar({required this.title, required this.message});

  void normalSnackBar() {
    Get.snackbar(title, message);
  }

  void errorSnackBar() {
    Get.snackbar(title, message,
        backgroundColor: Colors.deepOrange,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP);
    Get.snackbar(title, message);
  }
}
