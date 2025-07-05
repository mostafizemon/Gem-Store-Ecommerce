part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  @override
  List<Object?> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final String? selectedSize;
  final bool isProductInCart;
  final bool isAddingToCart;
  final bool addToCartSuccess;
  final String? errorMessage;

  const ProductDetailsLoaded({
    this.selectedSize,
    this.isProductInCart = false,
    this.isAddingToCart = false,
    this.addToCartSuccess = false,
    this.errorMessage,
  });

  ProductDetailsLoaded copyWith({
    String? selectedSize,
    bool? isProductInCart,
    bool? isAddingToCart,
    bool? addToCartSuccess,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ProductDetailsLoaded(
      selectedSize: selectedSize ?? this.selectedSize,
      isProductInCart: isProductInCart ?? this.isProductInCart,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
      addToCartSuccess: addToCartSuccess ?? this.addToCartSuccess,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    selectedSize,
    isProductInCart,
    isAddingToCart,
    addToCartSuccess,
    errorMessage,
  ];
}
