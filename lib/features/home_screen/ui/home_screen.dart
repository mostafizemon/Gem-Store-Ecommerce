import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/app_constrains/app_routes.dart';
import 'package:gem_store/common/widgets/appbar_widget.dart';
import 'package:gem_store/features/home_screen/bloc/drawer_user_info_bloc.dart';
import 'package:gem_store/features/home_screen/bloc/home_bloc.dart';
import 'package:gem_store/features/home_screen/widgets/category_widget.dart';
import 'package:gem_store/features/home_screen/widgets/home_slider.dart';
import 'package:gem_store/features/home_screen/widgets/products_widget.dart';
import 'package:gem_store/theme/app_colors.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(LoadBannerEvent());
    context.read<HomeBloc>().add(const LoadProductsEvent(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerUserInfoBloc()..add(LoadDrawerUserInfo()),
      child: Scaffold(
        appBar: AppbarWidget(title: "Gemstore", onNotificationTap: () {}),
        drawer: BlocBuilder<DrawerUserInfoBloc, DrawerUserInfoState>(
          builder: (context, state) {
            String fullName = 'User Name';
            String email = 'user.email@example.com';

            if (state is DrawerUserInfoLoaded) {
              fullName = state.fullName ?? 'User Name';
              email = state.email ?? 'user.email@example.com';
            } else if (state is DrawerUserInfoError) {
              fullName = 'Error';
              email = state.message;
            }

            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(color: AppColors.introScreenBgColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundColor: AppColors.whiteColor,
                          child: Icon(
                            Icons.person,
                            size: 30.r,
                            color: AppColors.introScreenBgColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          fullName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Get.back(); // Close the drawer
                      // Navigate to home screen if not already there
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_bag),
                    title: Text('Orders'),
                    onTap: () {
                      Get.toNamed(AppRoutes.ordersScreen);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        body: ListView(
          children: [
            CategoryWidget(),
            HomeSlider(),
            SizedBox(height: 16.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ProductsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
