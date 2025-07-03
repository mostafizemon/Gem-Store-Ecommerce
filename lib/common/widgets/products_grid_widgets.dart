import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/common/model/products_model.dart';

import '../../theme/app_colors.dart';

class ProductsGridWidgets extends StatelessWidget {
  final ProductsModel product;
  const ProductsGridWidgets({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.images![0],
              height: 172.h,
              width: 126.w,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            product.name!,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            "\$ ${product.price}",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
