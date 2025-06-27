part of 'bottom_nav_cubit.dart';

@immutable
sealed class BottomNavState extends Equatable {
  const BottomNavState();
  @override
  List<Object?> get props => [];
}

final class BottomNavInitial extends BottomNavState {
  final int currentIndex;
  const BottomNavInitial({this.currentIndex = 0});
  @override
  List<Object?> get props => [currentIndex];
}

final class BottomNavChanged extends BottomNavState {
  final int currentIndex;
  const BottomNavChanged(this.currentIndex);
  @override
  List<Object?> get props => [currentIndex];
}
