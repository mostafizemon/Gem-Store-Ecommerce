import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginSignupWidget extends StatelessWidget {
  final String text;
  final String button;
  final VoidCallback onTap;
  const LoginSignupWidget({
    super.key,
    required this.text,
    required this.button,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: onTap,
          child: Text(button, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
