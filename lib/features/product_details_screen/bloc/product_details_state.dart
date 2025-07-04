part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

class SelectedSizeIndex extends ProductDetailsState {
  final int sizeIndex;
  const SelectedSizeIndex(this.sizeIndex);
  @override
  List<Object> get props => [sizeIndex];
}

class AddToCartloading extends ProductDetailsState {}

class AddToCartSuccess extends ProductDetailsState {}

class AddToCartError extends ProductDetailsState {
  final String error;
  const AddToCartError(this.error);
  @override
  List<Object> get props => [error];
}
