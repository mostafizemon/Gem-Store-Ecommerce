part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();
  @override
  List<Object> get props => [];
}

class SelectedSizeevent extends ProductDetailsEvent {
  final String size;
  const SelectedSizeevent(this.size);
  @override
  List<Object> get props => [size];
}

class AddToCartevent extends ProductDetailsEvent {
  final String productID;
  final String size;
  const AddToCartevent(this.productID, this.size);
  @override
  List<Object> get props => [productID, size];
}

class CheckProductInCart extends ProductDetailsEvent {
  final String productID;
  const CheckProductInCart(this.productID);
  @override
  List<Object> get props => [productID];
}
