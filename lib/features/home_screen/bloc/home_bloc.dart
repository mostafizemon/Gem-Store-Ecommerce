import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gem_store/features/home_screen/model/banner_model.dart';
import 'package:gem_store/features/home_screen/model/products_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeLoaded()) {
    on<SelectCategoryEvent>(_onSelectCategory);
    on<LoadBannerEvent>(_onLoadBanner);
    on<ChangeBannerPageEvent>(_onChangeBannerPage);
    on<LoadProductsEvent>(_onLoadProducts);
    // add(LoadProductsEvent(0));
  }
  FutureOr<void> _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      emit(
        (state as HomeLoaded).copyWith(selectedCategoryID: event.selectedId),
      );
    }
  }

  FutureOr<void> _onLoadBanner(
    LoadBannerEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state is HomeLoaded
        ? (state as HomeLoaded)
        : HomeLoaded();
    emit(currentState.copyWith(isBannerLoading: true));
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('banner')
          .get();
      final banners = snapshot.docs
          .map((e) => BannerModel.fromMap(e.data()))
          .toList();

      if (state is HomeLoaded) {
        emit(
          (state as HomeLoaded).copyWith(
            banners: banners,
            isBannerLoading: false,
          ),
        );
      } else {
        emit(HomeLoaded(banners: banners, isBannerLoading: false));
      }
    } catch (e) {
      debugPrint("Error loading banners: $e");
    }
  }

  FutureOr<void> _onChangeBannerPage(
    ChangeBannerPageEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      emit((state as HomeLoaded).copyWith(currentIndex: event.pageIndex));
    }
  }

  FutureOr<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      emit((state as HomeLoaded).copyWith(isProductsLoading: true));

      final categoryMap = {0: "women", 1: "men", 2: "accessories", 3: "beauty"};

      final selectedCategory = categoryMap[event.selectedId];
      if (selectedCategory == null) return;

      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('products')
            .where('category', isEqualTo: selectedCategory)
            .get();
        final products = snapshot.docs
            .map((e) => ProductsModel.fromJson(e.data()))
            .toList();
        print(products.map((p) => p.name).toList());
        if (state is HomeLoaded) {
          emit(
            (state as HomeLoaded).copyWith(
              selectedCategoryID: event.selectedId,
              products: products,
              isProductsLoading: false,
            ),
          );
        }
      } catch (e) {
        debugPrint('Error loading products: $e');
      }
    }
  }
}
