import 'package:flutter/material.dart';
import 'package:gem_store/theme/app_colors.dart';

class IntroScreenButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const IntroScreenButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          AppColors.introScreenButtonBgColor,
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: AppColors.whiteColor,
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 32)),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
