import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  const BackButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(-1, 1),
            ),
          ],
        ),
        child: Center(child: Icon(Icons.arrow_back_ios, size: 20)),
      ),
    );
  }
}
