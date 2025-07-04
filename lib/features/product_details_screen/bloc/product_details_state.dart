part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  @override
  List<Object?> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final int? selectedSizeIndex;
  final bool isProductInCart;
  final bool isAddingToCart;
  final bool addToCartSuccess;
  final String? errorMessage;

  const ProductDetailsLoaded({
    this.selectedSizeIndex,
    this.isProductInCart = false,
    this.isAddingToCart = false,
    this.addToCartSuccess = false,
    this.errorMessage,
  });

  ProductDetailsLoaded copyWith({
    int? selectedSizeIndex,
    bool? isProductInCart,
    bool? isAddingToCart,
    bool? addToCartSuccess,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ProductDetailsLoaded(
      selectedSizeIndex: selectedSizeIndex ?? this.selectedSizeIndex,
      isProductInCart: isProductInCart ?? this.isProductInCart,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
      addToCartSuccess: addToCartSuccess ?? this.addToCartSuccess,
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedSizeIndex,
        isProductInCart,
        isAddingToCart,
        addToCartSuccess,
        errorMessage,
      ];
}