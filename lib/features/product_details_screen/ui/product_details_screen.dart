import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/common/model/products_model.dart';
import 'package:gem_store/features/product_details_screen/bloc/product_details_bloc.dart';
import 'package:gem_store/features/product_details_screen/widgets/product_details_widget.dart';
import 'package:gem_store/theme/app_colors.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsModel product = Get.arguments;
    return BlocProvider(
      create: (context) =>
          ProductDetailsBloc()..add(CheckProductInCart(product.documentId!)),
      child: ProductDetailsView(product: product),
    );
  }
}

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight,
            width: double.infinity,
            child: CarouselSlider(
              items: product.images!
                  .map(
                    (image) => Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: screenHeight,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
              ),
            ),
          ),

          // Content that will scroll over the images
          ProductDetailsWidget(product: product),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                padding: const EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          bool isButtonDisabled = true;
          String buttonText = "Add To Cart";
          Color buttonColor = AppColors.introScreenBgColor;

          if (state is ProductDetailsLoaded) {
            isButtonDisabled = state.isProductInCart || state.addToCartSuccess;
            if (isButtonDisabled) {
              buttonText = "Added to Cart";
              buttonColor = Colors.green;
            }
          }
          return GestureDetector(
            onTap: isButtonDisabled
                ? null
                : () {
                    if (state is ProductDetailsLoaded) {
                      if (state.selectedSize != null) {
                        context.read<ProductDetailsBloc>().add(
                          AddToCartevent(
                            product.documentId!,
                            state.selectedSize!,
                          ),
                        );
                      } else {
                        Get.snackbar(
                          "Please select a size",
                          "You must choose a size before adding to cart.",
                          backgroundColor: Colors.red.shade100,
                          colorText: Colors.black,
                        );
                      }
                    }
                  },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 72.h,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag, color: AppColors.whiteColor),
                  SizedBox(width: 8.w),
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
