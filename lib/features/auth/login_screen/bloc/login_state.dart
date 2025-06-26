part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class PasswordToggleButtonState extends LoginState{
  final bool isVisible;
  PasswordToggleButtonState(this.isVisible);
}
