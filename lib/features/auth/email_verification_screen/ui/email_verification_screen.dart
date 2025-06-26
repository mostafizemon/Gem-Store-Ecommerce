import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/features/auth/login_screen/ui/login_screen.dart';
import 'package:gem_store/features/auth/widgets/auth_header_widgets.dart';
import 'package:gem_store/features/auth/widgets/auth_subheader_widget.dart';
import 'package:gem_store/features/auth/widgets/back_button_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            BackButtonWidget(
              onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 16.h),
                  AuthHeaderWidgets(header: "Verification Code"),
                  SizedBox(height: 16.h),
                  AuthSubheaderWidget(
                    text:
                        "Please enter the verificaton code we sent to your email address",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
