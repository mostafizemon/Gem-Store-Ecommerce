import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/theme/app_colors.dart';

class AuthSubheaderWidget extends StatelessWidget {
  final String text;
  const AuthSubheaderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.greyColor,
        letterSpacing: 1,
      ),
    );
  }
}
