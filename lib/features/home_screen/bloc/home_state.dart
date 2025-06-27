part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  final List<BannerModel> banners;
  final int currentIndex;
  final int selectedCategoryID;
  final bool isBannerLoading;

  const HomeLoaded({
    required this.banners,
    this.currentIndex = 0,
    this.selectedCategoryID = 0,
    this.isBannerLoading = false,
  });

  HomeLoaded copyWith({
    List<BannerModel>? banners,
    int? currentIndex,
    int? selectedCategoryID,
    bool? isBannerLoading,
  }) {
    return HomeLoaded(
      banners: banners ?? this.banners,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedCategoryID: selectedCategoryID ?? this.selectedCategoryID,
      isBannerLoading: isBannerLoading ?? this.isBannerLoading,
    );
  }

  @override
  List<Object?> get props => [banners, currentIndex, selectedCategoryID];
}
