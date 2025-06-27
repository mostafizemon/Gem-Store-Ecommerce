part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

class CategorySelected extends HomeState {
  final int selectedID;
  const CategorySelected(this.selectedID);
  @override
  List<Object?> get props => [selectedID];
}