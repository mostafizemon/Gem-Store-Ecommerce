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
      final cartSnapshot = await cartCollection.where('userUid', isEqualTo: userUid).get();

      if (cartSnapshot.docs.isEmpty) {
        emit(const CartLoaded([]));
        return;
      }

      final productIds = cartSnapshot.docs.map((doc) => doc['productID'] as String).toList();

      final productsCollection = FirebaseFirestore.instance.collection('products');
      final productsSnapshot = await productsCollection.where(FieldPath.documentId, whereIn: productIds).get();

      final products = productsSnapshot.docs.map((doc) => ProductsModel.fromFirestore(doc)).toList();

      emit(CartLoaded(products));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}