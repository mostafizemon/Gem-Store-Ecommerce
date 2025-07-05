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
    on<CheckProductInCart>(onCheckProductInCart);
  }

  FutureOr<void> onSelectedSize(
    SelectedSizeevent event,
    Emitter<ProductDetailsState> emit,
  ) {
    if (state is ProductDetailsLoaded) {
      final currentState = state as ProductDetailsLoaded;
      emit(currentState.copyWith(selectedSize: event.size));
    }
  }

  FutureOr<void> onAddToCart(
    AddToCartevent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    if (state is ProductDetailsLoaded) {
      final currentState = state as ProductDetailsLoaded;
      emit(
        currentState.copyWith(isAddingToCart: true, clearErrorMessage: true),
      );
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final userUid = prefs.getString('uid');
      if (userUid == null) {
        if (state is ProductDetailsLoaded) {
          final currentState = state as ProductDetailsLoaded;
          emit(
            currentState.copyWith(
              isAddingToCart: false,
              errorMessage: 'User not logged in',
            ),
          );
        }
        return;
      }
      final cartCollection = FirebaseFirestore.instance.collection('cart');
      await cartCollection.doc().set({
        'userUid': userUid,
        'productID': event.productID,
        'size': event.size,
        'quantity': 1,
        'createdAt': Timestamp.now(),
      });
      if (state is ProductDetailsLoaded) {
        final currentState = state as ProductDetailsLoaded;
        emit(
          currentState.copyWith(
            isAddingToCart: false,
            addToCartSuccess: true,
            isProductInCart: true,
          ),
        );
      }
    } catch (e) {
      if (state is ProductDetailsLoaded) {
        final currentState = state as ProductDetailsLoaded;
        emit(
          currentState.copyWith(
            isAddingToCart: false,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  FutureOr<void> onCheckProductInCart(
    CheckProductInCart event,
    Emitter<ProductDetailsState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userUid = prefs.getString('uid');
      if (userUid == null) {
        emit(ProductDetailsLoaded(isProductInCart: false));
        return;
      }
      final cartCollection = FirebaseFirestore.instance.collection('cart');
      final querySnapshot = await cartCollection
          .where('userUid', isEqualTo: userUid)
          .where('productID', isEqualTo: event.productID)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        emit(ProductDetailsLoaded(isProductInCart: true));
      } else {
        emit(ProductDetailsLoaded(isProductInCart: false));
      }
    } catch (e) {
      emit(ProductDetailsLoaded(isProductInCart: false));
    }
  }
}
