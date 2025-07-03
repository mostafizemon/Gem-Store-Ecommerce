import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gem_store/common/model/products_model.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchProducts>(_onSearchProducts);
  }

  FutureOr<void> _onSearchProducts(
    SearchProducts event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query;
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try{
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('name')
          .startAt([query])
          .endAt(['$query\uf8ff'])
          .get();

      final results = snapshot.docs.map((e) {
        final data = Map<String, dynamic>.from(e.data());
        data['documentId'] = e.id;
        return ProductsModel.fromJson(data);
      }).toList();
      emit(SearchLoaded(results));
      print(results.length);
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
