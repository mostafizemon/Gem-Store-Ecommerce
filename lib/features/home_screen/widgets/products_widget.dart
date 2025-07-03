import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/common/widgets/products_grid_widgets.dart';
import 'package:gem_store/features/home_screen/bloc/home_bloc.dart';
import 'package:gem_store/common/model/products_model.dart';
import 'package:gem_store/theme/app_colors.dart';
import 'package:get/get.dart';

import '../../../app_constrains/app_routes.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          if (state.isProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.products.isEmpty) {
            return Center(
              child: Text(
                "No Prodcuts Found in this Category",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greyColor,
                ),
              ),
            );
          }
          return GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.productDetailsScreen),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 4.h,
                childAspectRatio: 0.65,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                ProductsModel product = state.products[index];
                return ProductsGridWidgets(product: product);
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
