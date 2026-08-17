part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final bool isDriver;

  const LoginEvent({
    required this.email,
    required this.password,
    this.isDriver = false,
  });

  @override
  List<Object?> get props => [email, password, isDriver];
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final bool isDriver;

  const SignupEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    this.isDriver = false,
  });

  @override
  List<Object?> get props => [email, password, fullName, phoneNumber, isDriver];
}

class LogoutEvent extends AuthEvent {}

class CheckAuthEvent extends AuthEvent {}