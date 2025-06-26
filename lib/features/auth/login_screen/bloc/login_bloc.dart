import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gem_store/features/auth/repositories/auth_reposityory.dart';
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
        emit(LoginSuccess());
      } else {
        emit(
          LoginFailed("Email not verified. A verification link has been sent."),
        );
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          emit(LoginFailed("The email address is invalid."));
          break;
        case 'user-not-found':
          emit(LoginFailed("No user found for that email."));
          break;
        case 'wrong-password':
          emit(LoginFailed("Incorrect password. Please try again."));
          break;
        case 'user-disabled':
          emit(LoginFailed("This user account has been disabled."));
          break;
        case 'email-not-verified':
          emit(
            LoginFailed("Email not verified. Check your inbox for the link."),
          );
          break;
        default:
          emit(LoginFailed("Authentication failed. ${e.message}"));
      }
    } catch (e) {
      emit(LoginFailed("An unexpected error occurred."));
    }
  }
}
