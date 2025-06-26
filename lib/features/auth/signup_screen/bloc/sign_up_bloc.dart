import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gem_store/features/auth/repositories/auth_reposityory.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc()
    : super(
        const SignUpVisibilityState(
          isPasswordVisible: false,
          isConfirmPasswordVisible: false,
        ),
      ) {
    on<TogglePasswordVisibily>(_togglePasswordVisibily);
    on<ToggleConfirmPasswordVisibily>(_toggleConfirmPasswordVisibily);
    on<SignupSubmitted>(_signup);
  }

  void _togglePasswordVisibily(
    TogglePasswordVisibily event,
    Emitter<SignUpState> emit,
  ) {
    if (state is SignUpVisibilityState) {
      final current = state as SignUpVisibilityState;
      emit(
        SignUpVisibilityState(
          isPasswordVisible: !current.isPasswordVisible,
          isConfirmPasswordVisible: current.isConfirmPasswordVisible,
        ),
      );
    }
  }

  void _toggleConfirmPasswordVisibily(
    ToggleConfirmPasswordVisibily event,
    Emitter<SignUpState> emit,
  ) {
    if (state is SignUpVisibilityState) {
      final current = state as SignUpVisibilityState;
      emit(
        SignUpVisibilityState(
          isPasswordVisible: current.isPasswordVisible,
          isConfirmPasswordVisible: !current.isConfirmPasswordVisible,
        ),
      );
    }
  }

  FutureOr<void> _signup(
    SignupSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    try {
      final user = await AuthRepository().signUp(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      if (user != null) {
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure("Something went wrong."));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(SignUpFailure("This email is already registered."));
      } else {
        emit(SignUpFailure("Error: ${e.message ?? "Unknown error"}"));
      }
    } catch (e) {
      emit(SignUpFailure("Unexpected error occurred."));
    }
  }
}
