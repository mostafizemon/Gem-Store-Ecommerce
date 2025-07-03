import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/model/products_model.dart';
import '../../../theme/app_colors.dart';

class SizeWidget extends StatelessWidget {
  final ProductsModel product;
  const SizeWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(
          "Size:",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: SizedBox(
            height: 32.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return CircleAvatar(
                  backgroundColor: AppColors.introScreenBgColor,
                  child: Text(
                    product.size![index],
                    style: TextStyle(
                      color: AppColors.whiteColor,
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 4.w);
              },
              itemCount: product.size!.length,
            ),
          ),
        ),
      ],
    );
  }
}
