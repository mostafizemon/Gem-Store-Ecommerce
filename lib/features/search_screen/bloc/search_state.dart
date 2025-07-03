part of 'search_bloc.dart';

@immutable
sealed class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductsModel> results;
  const SearchLoaded(this.results);
  @override
  List<Object?> get props => [results];
}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);
  @override
  List<Object?> get props => [message];
}
