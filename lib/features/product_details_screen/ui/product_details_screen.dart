import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/common/model/products_model.dart';
import 'package:gem_store/features/product_details_screen/widgets/size_widget.dart';
import 'package:get/get.dart';
import '../widgets/product_review_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsModel product = Get.arguments;
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
          Positioned.fill(
            child: DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    children: [
                      Text(
                        product.name ?? 'No Title',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ProductReviewWidget(product: product),
                      SizedBox(height: 16.h),
                      SizeWidget(product: product),
                      SizedBox(height: 16.h),
                      Text(
                        product.description ?? 'No description available',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              },
            ),
          ),

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
    );
  }
}
