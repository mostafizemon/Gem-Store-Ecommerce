part of 'confirm_order_bloc.dart';

sealed class ConfirmOrderEvent extends Equatable {
  const ConfirmOrderEvent();

  @override
  List<Object> get props => [];
}

class ConfirmOrder extends ConfirmOrderEvent {
  final String address;
  final String phoneNumber;
  final List<CartItem> cartItems;

  const ConfirmOrder({
    required this.address,
    required this.phoneNumber,
    required this.cartItems,
  });

  @override
  List<Object> get props => [address, phoneNumber, cartItems];
}
