import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:gem_store/features/cart_screen/bloc/cart_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'confirm_order_event.dart';
part 'confirm_order_state.dart';

class ConfirmOrderBloc extends Bloc<ConfirmOrderEvent, ConfirmOrderState> {
  ConfirmOrderBloc() : super(ConfirmOrderInitial()) {
    on<ConfirmOrder>(_onConfirmOrder);
  }

  Future<void> _onConfirmOrder(
    ConfirmOrder event,
    Emitter<ConfirmOrderState> emit,
  ) async {
    emit(ConfirmOrderLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userUid = prefs.getString('uid');

      if (userUid == null) {
        emit(const ConfirmOrderFailure('User not logged in. Please log in to place an order.'));
        return;
      }

      final orderItems = event.cartItems.map((item) => {
            'productId': item.product.documentId,
            'size': item.size,
            'quantity': item.quantity,
            'price': item.product.price,
          }).toList();

      await FirebaseFirestore.instance.collection('orders').add({
        'userUid': userUid,
        'address': event.address,
        'phoneNumber': event.phoneNumber,
        'items': orderItems,
        'totalAmount': event.cartItems.fold(0.0, (currentSum, item) => currentSum + (item.product.price! * item.quantity)),
        'orderDate': Timestamp.now(),
        'status': 'Pending',
      });

      // Clear cart after successful order
      final batch = FirebaseFirestore.instance.batch();
      for (var item in event.cartItems) {
        batch.delete(FirebaseFirestore.instance.collection('cart').doc(item.cartDocId));
      }
      await batch.commit();

      emit(const ConfirmOrderSuccess('Order Placed Successfully!'));
    } catch (e) {
      emit(ConfirmOrderFailure('Failed to place order: ${e.toString()}'));
    }
  }
}
