import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_constrains/app_icons.dart';
import '../../theme/app_colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onNotificationTap;

  const AppbarWidget({super.key, required this.title, this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.sp,
          letterSpacing: 1.5,
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: SvgPicture.asset(
            AppIcons.menuIcon,
            height: 18.h,
            width: 18.w,
            colorFilter: ColorFilter.mode(
              AppColors.blackColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onNotificationTap ?? () {},
          icon: const Icon(Icons.notifications_none),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
