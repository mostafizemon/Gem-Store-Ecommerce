import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/model/products_model.dart';

class ProductReviewWidget extends StatelessWidget {
  final ProductsModel product;
  const ProductReviewWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          product.review?.ratting?.toStringAsFixed(1) ??
              '0.0',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 8.w),
        RatingBarIndicator(
          rating: product.review?.ratting ?? 0,
          itemBuilder: (context, index) =>
          const Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: 20.sp,
          direction: Axis.horizontal,
        ),
        SizedBox(width: 8.w),
        Text(
          "(${product.review?.totalreview ?? "0"})",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
