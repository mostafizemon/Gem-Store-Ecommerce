import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure("Error: ${e.toString()}"));
    }
  }
}
