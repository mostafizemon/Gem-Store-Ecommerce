import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gem_store/common/model/products_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<FetchCartItems>(_onFetchCartItems);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<RemoveCartItem>(_onRemoveCartItem);
  }

  Future<void> _onFetchCartItems(
    FetchCartItems event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userUid = prefs.getString('uid');

      if (userUid == null) {
        emit(const CartError('User not logged in'));
        return;
      }

      final cartCollection = FirebaseFirestore.instance.collection('cart');
      final cartSnapshot = await cartCollection
          .where('userUid', isEqualTo: userUid)
          .get();

      if (cartSnapshot.docs.isEmpty) {
        emit(const CartLoaded([]));
        return;
      }

      final List<CartItem> cartItems = [];
      for (var cartDoc in cartSnapshot.docs) {
        final productID = cartDoc['productID'] as String;
        final size = cartDoc['size'] as String;
        final quantity = cartDoc['quantity'] as int;
        final cartDocId = cartDoc.id;

        final productSnapshot = await FirebaseFirestore.instance
            .collection('products')
            .doc(productID)
            .get();
        if (productSnapshot.exists) {
          final product = ProductsModel.fromFirestore(productSnapshot);
          cartItems.add(
            CartItem(
              product: product,
              size: size,
              quantity: quantity,
              cartDocId: cartDocId,
            ),
          );
        }
      }

      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onUpdateCartItemQuantity(
    UpdateCartItemQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(event.cartDocId)
          .update({'quantity': event.newQuantity});

      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final updatedCartItems = currentState.cartItems.map((item) {
          return item.cartDocId == event.cartDocId
              ? item.copyWith(quantity: event.newQuantity)
              : item;
        }).toList();
        emit(CartLoaded(updatedCartItems));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveCartItem(
    RemoveCartItem event,
    Emitter<CartState> emit,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(event.cartDocId)
          .delete();

      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final updatedCartItems = currentState.cartItems
            .where((item) => item.cartDocId != event.cartDocId)
            .toList();
        emit(CartLoaded(updatedCartItems));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
