import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeaderWidgets extends StatelessWidget {
  final String header;
  const AuthHeaderWidgets({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Text(header,style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold),);
  }
}
