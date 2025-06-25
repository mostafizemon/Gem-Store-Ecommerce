import 'package:gem_store/utils/image_util.dart';

class IntroData {
  final String image;
  final String title;
  final String subtitle;

  IntroData({required this.image, required this.title, required this.subtitle});

  static final List<IntroData> introDataList = [
    IntroData(
      image: ImageUtil.introScreenImage1,
      title: "Discover something new",
      subtitle: "Special new arrivals just for you",
    ),
    IntroData(
      image: ImageUtil.introScreenImage2,
      title: "Update trendy outfit",
      subtitle: "Favorite brands and hottest trends",
    ),
    IntroData(
      image: ImageUtil.introScreenImage3,
      title: "Explore your true style",
      subtitle: "Relax and let us bring the style to you",
    ),
  ];
}
