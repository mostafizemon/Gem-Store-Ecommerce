part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();
  @override
  List<Object> get props => [];
}

class SelectedSizeevent extends ProductDetailsEvent {
  final int sizeIndex;
  const SelectedSizeevent(this.sizeIndex);
  @override
  List<Object> get props => [sizeIndex];
}

class AddToCartevent extends ProductDetailsEvent {
  final String productID;
  final int sizeIndex;
  const AddToCartevent(this.productID, this.sizeIndex);
  @override
  List<Object> get props => [productID, sizeIndex];
}
