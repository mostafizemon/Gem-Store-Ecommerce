import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<SelectedSizeevent>(onSelectedSize);
    on<AddToCartevent>(onAddToCart);
  }

  FutureOr<void> onSelectedSize(
    SelectedSizeevent event,
    Emitter<ProductDetailsState> emit,
  ) {
    emit(SelectedSizeIndex(event.sizeIndex));
  }

  FutureOr<void> onAddToCart(
    AddToCartevent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(AddToCartloading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userUid = prefs.getString('uid');
      if (userUid == null) {
        emit(AddToCartError('User not logged in'));
        return;
      }
      final cartCollection = FirebaseFirestore.instance.collection('cart');
      await cartCollection.doc().set({
        'userUid': userUid,
        'productID': event.productID,
        'sizeIndex': event.sizeIndex,
        'quantity': 1,
        'createdAt': Timestamp.now(),
      });
      emit(AddToCartSuccess());
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }
  }
}
