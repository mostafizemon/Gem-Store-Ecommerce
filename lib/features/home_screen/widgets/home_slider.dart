// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gem_store/features/home_screen/bloc/home_bloc.dart';
// import 'package:gem_store/features/home_screen/model/banner_model.dart';
// import 'package:gem_store/theme/app_colors.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class HomeSlider extends StatelessWidget {
//   const HomeSlider({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         if (state is BannerLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is BannerError) {
//           return Center(child: Text("Error: ${state.error}"));
//         } else if (state is BannerLoaded) {
//           final List<BannerModel> banners = state.banners;
//           final currentIndex = state.currentIndex;
//           return Column(
//             children: [
//               CarouselSlider(
//                 options: CarouselOptions(
//                   height: 170.0.h,
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   viewportFraction: 0.9,
//                   aspectRatio: 16 / 9,
//                   autoPlayInterval: const Duration(seconds: 3),
//                   onPageChanged: (index, reason) {
//                     context.read<HomeBloc>().add(ChangeBannerPageEvent(index));
//                   },
//                 ),
//                 items: banners.map((banner) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           banner.imageUrl,
//                           height: 168.h,
//                           fit: BoxFit.cover,
//                           width: MediaQuery.of(context).size.width,
//                           errorBuilder: (context, error, stackTrace) =>
//                               const Center(child: Icon(Icons.error)),
//                         ),
//                       );
//                     },
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 8.h),
//               AnimatedSmoothIndicator(
//                 activeIndex: currentIndex,
//                 count: banners.length,
//                 effect: WormEffect(
//                   activeDotColor: Colors.black,
//                   dotHeight: 8.h,
//                   dotWidth: 8.w,
//                   dotColor: AppColors.greyColor,
//                 ),
//               ),
//             ],
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/features/home_screen/bloc/home_bloc.dart';
import 'package:gem_store/features/home_screen/model/banner_model.dart';
import 'package:gem_store/theme/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          if (state.isBannerLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final List<BannerModel> banners = state.banners;
          final int currentIndex = state.currentIndex;

          if (banners.isEmpty) {
            return const Center(child: Text("No banners available."));
          }

          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 170.0.h,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    context.read<HomeBloc>().add(ChangeBannerPageEvent(index));
                  },
                ),
                items: banners.map((banner) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          banner.imageUrl,
                          height: 168.h,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 8.h),
              AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: banners.length,
                effect: WormEffect(
                  activeDotColor: Colors.black,
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  dotColor: AppColors.greyColor,
                ),
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
