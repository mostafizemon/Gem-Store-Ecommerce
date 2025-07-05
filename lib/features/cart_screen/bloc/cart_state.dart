part of 'cart_bloc.dart';

@immutable
sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

class CartItem extends Equatable {
  final ProductsModel product;
  final String size;
  final int quantity;
  final String cartDocId;

  const CartItem({
    required this.product,
    required this.size,
    required this.quantity,
    required this.cartDocId,
  });

  @override
  @override
  List<Object> get props => [product, size, quantity, cartDocId];

  CartItem copyWith({
    ProductsModel? product,
    String? size,
    int? quantity,
    String? cartDocId,
  }) {
    return CartItem(
      product: product ?? this.product,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      cartDocId: cartDocId ?? this.cartDocId,
    );
  }
}

final class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  const CartLoaded(this.cartItems);

  @override
  List<Object> get props => [cartItems];

  CartLoaded copyWith({
    List<CartItem>? cartItems,
  }) {
    return CartLoaded(
      cartItems ?? this.cartItems,
    );
  }
}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
