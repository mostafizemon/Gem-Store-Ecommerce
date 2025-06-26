part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class PasswordToggleButtonEvent extends LoginEvent{}
class SubmitLoginButtonEvent extends LoginEvent{
  final String email;
  final String password;

  const SubmitLoginButtonEvent(this.email, this.password);
  @override
  List<Object?> get props => [email,password];
}
