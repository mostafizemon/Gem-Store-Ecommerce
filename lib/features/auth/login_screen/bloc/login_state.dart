part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {}

class PasswordToggleButtonState extends LoginState {
  final bool isVisible;
  const PasswordToggleButtonState(this.isVisible);
  @override
  List<Object?> get props => [isVisible];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String error;
  const LoginFailed(this.error);
  @override
  List<Object?> get props => [error];
}
