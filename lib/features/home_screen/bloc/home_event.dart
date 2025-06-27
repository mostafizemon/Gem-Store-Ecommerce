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

class LoadBannerEvent extends HomeEvent {}

class ChangeBannerPageEvent extends HomeEvent {
  final int pageIndex;
  const ChangeBannerPageEvent(this.pageIndex);
  @override
  List<Object?> get props => [pageIndex];
}
