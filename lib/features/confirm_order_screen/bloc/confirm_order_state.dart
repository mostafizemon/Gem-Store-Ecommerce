part of 'confirm_order_bloc.dart';

sealed class ConfirmOrderState extends Equatable {
  const ConfirmOrderState();

  @override
  List<Object> get props => [];
}

final class ConfirmOrderInitial extends ConfirmOrderState {}

final class ConfirmOrderLoading extends ConfirmOrderState {}

final class ConfirmOrderSuccess extends ConfirmOrderState {
  final String message;

  const ConfirmOrderSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class ConfirmOrderFailure extends ConfirmOrderState {
  final String error;

  const ConfirmOrderFailure(this.error);

  @override
  List<Object> get props => [error];
}
