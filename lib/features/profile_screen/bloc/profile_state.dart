part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final String? fullName;
  final String? email;
  final int totalOrders;

  const ProfileLoaded({
    this.fullName,
    this.email,
    required this.totalOrders,
  });

  @override
  List<Object?> get props => [fullName, email, totalOrders];
}

final class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

final class ProfileLoggedOut extends ProfileState {}
