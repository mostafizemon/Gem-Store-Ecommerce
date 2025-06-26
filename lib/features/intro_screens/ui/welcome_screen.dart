import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/app_constrains/app_routes.dart';
import 'package:gem_store/common/widgets/intro_screen_button.dart';
import 'package:gem_store/features/intro_screens/ui/intro_screen.dart';
import 'package:gem_store/app_constrains/app_images.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageUtil.welcomeScreenImage,
            width: size.width.w,
            height: size.height.h,
            fit: BoxFit.cover,
          ),
          Container(
            height: size.height.h,
            width: size.width.w,
            color: Colors.black54,
          ),

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.60.h),
                Text(
                  "Welcome to GemStore!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "The home for a fashionista",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.h),
                IntroScreenButton(
                  buttonText: "Get Started",
                  onTap: () {
                    Get.offNamed(AppRoutes.introScreen);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
