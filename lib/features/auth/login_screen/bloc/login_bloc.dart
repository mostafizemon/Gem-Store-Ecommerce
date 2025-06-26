import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gem_store/features/auth/repositories/auth_reposityory.dart';
import 'package:gem_store/services/local_storage_service.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<PasswordToggleButtonEvent>(passwordToggleButtonEvent);
    on<SubmitLoginButtonEvent>(onLoginSubmit);
  }

  bool isPasswordVisible = false;
  FutureOr<void> passwordToggleButtonEvent(
    PasswordToggleButtonEvent event,
    Emitter<LoginState> emit,
  ) {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordToggleButtonState(isPasswordVisible));
  }


  FutureOr<void> onLoginSubmit(
      SubmitLoginButtonEvent event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    try {
      final user = await AuthRepository().login(
        email: event.email,
        password: event.password,
      );
      if (user != null && user.emailVerified) {
        await LocalStorageService().saveUserData(
          uid: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
        );
        emit(LoginSuccess());
      } else if (user != null) {
        emit(LoginFailed("Please verify your email first"));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'invalid-credential' || e.code == 'INVALID_LOGIN_CREDENTIALS') {
        errorMessage = "Invalid email or password";
      }
      else {
        switch (e.code) {
        case 'invalid-email':
          errorMessage = "The email address is invalid";
          break;
        case 'user-disabled':
          errorMessage = "This account has been disabled";
          break;
        default:
          errorMessage = "Login failed. Please try again";
      }
      }

      emit(LoginFailed(errorMessage));
    } catch (e) {
      emit(LoginFailed("An unexpected error occurred"));
    }
  }
}
