part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartItems extends CartEvent {}

class UpdateCartItemQuantity extends CartEvent {
  final String cartDocId;
  final int newQuantity;

  const UpdateCartItemQuantity(this.cartDocId, this.newQuantity);

  @override
  List<Object> get props => [cartDocId, newQuantity];
}

class RemoveCartItem extends CartEvent {
  final String cartDocId;

  const RemoveCartItem(this.cartDocId);

  @override
  List<Object> get props => [cartDocId];
}