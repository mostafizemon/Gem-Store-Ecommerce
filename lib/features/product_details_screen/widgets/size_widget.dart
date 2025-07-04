import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/features/product_details_screen/bloc/product_details_bloc.dart';

import '../../../common/model/products_model.dart';
import '../../../theme/app_colors.dart';

class SizeWidget extends StatelessWidget {
  final ProductsModel product;

  const SizeWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Size:",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: SizedBox(
            height: 32.h,
            child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              builder: (context, state) {
                int? selectedIndex;
                if (state is ProductDetailsLoaded) {
                  selectedIndex = state.selectedSizeIndex;
                }

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.size?.length ?? 0,
                  separatorBuilder: (_, __) => SizedBox(width: 4.w),
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        context.read<ProductDetailsBloc>().add(
                          SelectedSizeevent(index),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: isSelected
                            ? AppColors.introScreenBgColor
                            : Colors.grey.shade300,
                        child: Text(
                          product.size![index],
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.whiteColor
                                : AppColors.introScreenBgColor,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
