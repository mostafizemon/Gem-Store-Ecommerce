import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/app_constrains/app_routes.dart';
import 'package:gem_store/features/profile_screen/bloc/profile_bloc.dart';
import 'package:gem_store/theme/app_colors.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(FetchProfileData()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoggedOut) {
            Get.offAllNamed(AppRoutes.loginScreen);
          } else if (state is ProfileError) {
            Get.snackbar(
              "Error",
              state.message,
              backgroundColor: Colors.red.shade100,
              colorText: Colors.black,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                  letterSpacing: 1.5,
                ),
              ),
              centerTitle: true,
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProfileState state) {
    if (state is ProfileLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProfileLoaded) {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: AppColors.introScreenBgColor,
                child: Icon(
                  Icons.person,
                  size: 50.r,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            _buildInfoRow('Full Name', state.fullName ?? 'N/A'),
            SizedBox(height: 16.h),
            _buildInfoRow('Email', state.email ?? 'N/A'),
            SizedBox(height: 16.h),
            _buildInfoRow('Total Orders', state.totalOrders.toString()),
            SizedBox(height: 24.h),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(Logout());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.introScreenBgColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (state is ProfileError) {
      return Center(child: Text(state.message));
    } else if (state is ProfileInitial) {
      return const Center(child: Text('Initializing profile...'));
    }
    return const SizedBox.shrink();
  }

  Widget _buildInfoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
