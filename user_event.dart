part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserEvent extends UserEvent {
  final String userId;

  const LoadUserEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class UpdateUserEvent extends UserEvent {
  final User user;

  const UpdateUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class LoadPaymentMethodsEvent extends UserEvent {
  final String userId;

  const LoadPaymentMethodsEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class AddPaymentMethodEvent extends UserEvent {
  final String userId;
  final PaymentMethod method;

  const AddPaymentMethodEvent({
    required this.userId,
    required this.method,
  });

  @override
  List<Object?> get props => [userId, method];
}

class RemovePaymentMethodEvent extends UserEvent {
  final String userId;
  final String methodId;

  const RemovePaymentMethodEvent({
    required this.userId,
    required this.methodId,
  });

  @override
  List<Object?> get props => [userId, methodId];
}

class SetDefaultPaymentMethodEvent extends UserEvent {
  final String userId;
  final String methodId;

  const SetDefaultPaymentMethodEvent({
    required this.userId,
    required this.methodId,
  });

  @override
  List<Object?> get props => [userId, methodId];
}