part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class SelectCategoryEvent extends HomeEvent {
  final int selectedId;
  const SelectCategoryEvent(this.selectedId);
  @override
  List<Object?> get props => [selectedId];
}
