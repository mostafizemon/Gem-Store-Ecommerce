part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object> get props => [];
}

class TogglePasswordVisibily extends SignUpEvent {}

class ToggleConfirmPasswordVisibily extends SignUpEvent {}

class SignupSubmitted extends SignUpEvent {
  final String email;
  final String password;
  final String name;
  const SignupSubmitted(this.email, this.password, this.name);
  @override
  List<Object> get props => [email, password, name];
}
