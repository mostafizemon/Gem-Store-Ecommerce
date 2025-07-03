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
  final bool isProductsLoading;
  final List<ProductsModel> products;

  const HomeLoaded({
    this.banners = const [],
    this.currentIndex = 0,
    this.selectedCategoryID = 0,
    this.isBannerLoading = false,
    this.isProductsLoading = false,
    this.products = const [],
  });

  HomeLoaded copyWith({
    List<BannerModel>? banners,
    int? currentIndex,
    int? selectedCategoryID,
    bool? isBannerLoading,
    bool? isProductsLoading,
    List<ProductsModel>? products,
  }) {
    return HomeLoaded(
      banners: banners ?? this.banners,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedCategoryID: selectedCategoryID ?? this.selectedCategoryID,
      isBannerLoading: isBannerLoading ?? this.isBannerLoading,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
    banners,
    currentIndex,
    selectedCategoryID,
    products,
  ];
}
