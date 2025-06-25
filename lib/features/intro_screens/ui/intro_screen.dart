import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/common/widgets/intro_screen_button.dart';
import 'package:gem_store/features/intro_screens/cubit/intro_screen_cubit.dart';
import 'package:gem_store/features/intro_screens/data/intro_data.dart';
import 'package:gem_store/features/intro_screens/widgets/intro_screen_content_widget.dart';
import 'package:gem_store/theme/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final introData = IntroData.introDataList;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(height: size.height.h, color: AppColors.introScreenBgColor),
          Container(height: size.height * 0.5.h, color: Colors.white),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: introData.length,
                    onPageChanged: (int page) {
                      context.read<IntroScreenCubit>().onPageChanged(page);
                    },
                    itemBuilder: (context, index) {
                      final item = introData[index];
                      return IntroScreenContentWidget(
                        image: item.image,
                        title: item.title,
                        subtitle: item.subtitle,
                      );
                    },
                  ),
                ),
                SizedBox(height: 32.h),
                BlocBuilder<IntroScreenCubit, IntroScreenState>(
                  builder: (context, state) {
                    return AnimatedSmoothIndicator(
                      activeIndex: state.pageIndex,
                      count: introData.length,
                      effect: WormEffect(
                        dotHeight: 8.r,
                        dotWidth: 8.r,
                        activeDotColor: Colors.white,
                        dotColor: Colors.white54,
                      ),
                    );
                  },
                ),

                SizedBox(height: 32.h),
                IntroScreenButton(buttonText: "Shopping now", onTap: () {}),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
