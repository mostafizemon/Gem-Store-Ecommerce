import 'package:flutter/material.dart';
import 'package:gem_store/theme/app_colors.dart';
import 'package:get/get.dart';

void showCustomSnackbar(BuildContext context, String title, String message) {
  Get.snackbar(
    title,
    message,
    borderRadius: 8,
    backgroundColor: AppColors.introScreenBgColor,
    snackPosition: SnackPosition.BOTTOM,
    animationDuration: Duration(seconds: 2),
    colorText: Colors.white,
  );
}
