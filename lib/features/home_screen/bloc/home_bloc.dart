import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gem_store/features/home_screen/model/banner_model.dart';

part 'home_event.dart';
part 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc() : super(HomeInitial()) {
//     on<SelectCategoryEvent>(_onSelectCategory);
//     on<LoadBannerEvent>(_onLoadBanner);
//     on<ChangeBannerPageEvent>(_onChangeBannerPage);
//   }
//
//   FutureOr<void> _onSelectCategory(
//     SelectCategoryEvent event,
//     Emitter<HomeState> emit,
//   ) {
//     emit(CategorySelected(event.selectedId));
//   }
//
//   FutureOr<void> _onLoadBanner(
//     LoadBannerEvent event,
//     Emitter<HomeState> emit,
//   ) async {
//     emit(BannerLoading());
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('banner')
//           .get();
//       final banners = snapshot.docs
//           .map((e) => BannerModel.fromMap(e.data()))
//           .toList();
//       emit(BannerLoaded(banners));
//     } catch (e) {
//       emit(BannerError(e.toString()));
//     }
//   }
//
//   FutureOr<void> _onChangeBannerPage(
//       ChangeBannerPageEvent event,
//       Emitter<HomeState> emit,
//       ) {
//     if (state is BannerLoaded) {
//       emit(BannerLoaded(
//         (state as BannerLoaded).banners,
//         currentIndex: event.pageIndex,
//       ));
//     }
//   }
// }

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeLoaded(banners: [])) {
    on<SelectCategoryEvent>(_onSelectCategory);
    on<LoadBannerEvent>(_onLoadBanner);
    on<ChangeBannerPageEvent>(_onChangeBannerPage);
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
    if (state is HomeLoaded) {
      emit((state as HomeLoaded).copyWith(isBannerLoading: true));
    }
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
}
