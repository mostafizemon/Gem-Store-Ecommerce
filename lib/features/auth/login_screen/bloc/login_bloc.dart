import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<PasswordToggleButtonEvent>(passwordToggleButtonEvent);
  }

  bool isPasswordVisible=false;
  FutureOr<void> passwordToggleButtonEvent(
    PasswordToggleButtonEvent event,
    Emitter<LoginState> emit,
  ) {
    isPasswordVisible=!isPasswordVisible;
    emit(PasswordToggleButtonState(isPasswordVisible));
  }
}
