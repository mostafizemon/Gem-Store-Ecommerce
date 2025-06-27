// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gem_store/features/home_screen/bloc/home_bloc.dart';
// import '../../../data/categories_data.dart';
// import '../../../theme/app_colors.dart';
//
// class CategoryWidget extends StatelessWidget {
//   const CategoryWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final categories = CategoriesData.categories;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final itemWidth = screenWidth / 4;
//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         int selectedIndex = 0;
//         if (state is CategorySelected) {
//           selectedIndex = state.selectedID;
//         }
//
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: SizedBox(
//             height: 80.h,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 final category = categories[index];
//                 final bool isSelected = index == selectedIndex;
//
//                 return SizedBox(
//                   width: itemWidth,
//                   child: GestureDetector(
//                     onTap: () {
//                       context.read<HomeBloc>().add(
//                         SelectCategoryEvent(int.parse(category.id)),
//                       );
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 22.sp,
//                           backgroundColor: isSelected
//                               ? AppColors.blackColor
//                               : AppColors.greyColor.withValues(alpha: 0.2),
//                           child: Icon(
//                             category.icon,
//                             size: 32.sp,
//                             color: isSelected
//                                 ? Colors.white
//                                 : AppColors.blackColor,
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           category.name,
//                           style: TextStyle(
//                             color: isSelected
//                                 ? AppColors.blackColor
//                                 : AppColors.greyColor,
//                             fontWeight: isSelected
//                                 ? FontWeight.bold
//                                 : FontWeight.normal,
//                             fontSize: 12.sp,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/features/home_screen/bloc/home_bloc.dart';
import '../../../data/categories_data.dart';
import '../../../theme/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoriesData.categories;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 4;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        int selectedIndex = 0;

        // Use HomeLoaded state
        if (state is HomeLoaded) {
          selectedIndex = state.selectedCategoryID;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: SizedBox(
            height: 80.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final bool isSelected = index == selectedIndex;

                return SizedBox(
                  width: itemWidth,
                  child: GestureDetector(
                    onTap: () {
                      context.read<HomeBloc>().add(
                        SelectCategoryEvent(int.parse(category.id)),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 22.sp,
                          backgroundColor: isSelected
                              ? AppColors.blackColor
                              : AppColors.greyColor.withOpacity(0.2),
                          child: Icon(
                            category.icon,
                            size: 32.sp,
                            color: isSelected
                                ? Colors.white
                                : AppColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.blackColor
                                : AppColors.greyColor,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
