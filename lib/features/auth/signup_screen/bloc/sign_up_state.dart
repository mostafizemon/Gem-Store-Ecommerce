part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object?> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpVisibilityState extends SignUpState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const SignUpVisibilityState({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
  });
  @override
  List<Object?> get props => [isPasswordVisible, isConfirmPasswordVisible];
}

final class SignUpLoading extends SignUpState{}
final class SignUpSuccess extends SignUpState{}
final class SignUpFailure extends SignUpState{
  final String error;
  const SignUpFailure(this.error);
  @override
  List<Object?> get props => [error];
}


