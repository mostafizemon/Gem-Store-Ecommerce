import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_store/features/bottom_nav_screen/cubit/bottom_nav_cubit.dart';
import 'package:gem_store/features/cart_screen/ui/cart_screen.dart';
import 'package:gem_store/features/home_screen/ui/home_screen.dart';
import 'package:gem_store/features/profile_screen/ui/profile_screen.dart';
import 'package:gem_store/features/search_screen/ui/search_screen.dart';
import 'package:gem_store/theme/app_colors.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is BottomNavInitial) {
          currentIndex = state.currentIndex;
        } else if (state is BottomNavChanged) {
          currentIndex = state.currentIndex;
        }
        return Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border.all(
                color: AppColors.greyColor.withValues(alpha: 0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) =>
                    context.read<BottomNavCubit>().changeTab(index),
                selectedItemColor: AppColors.blackColor,
                unselectedItemColor: AppColors.greyColor,
                backgroundColor: AppColors.whiteColor,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined),
                    label: "Search",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
