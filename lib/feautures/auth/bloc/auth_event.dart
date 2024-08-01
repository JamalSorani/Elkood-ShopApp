part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String name;
  final String password;

  SignUpEvent({required this.name, required this.password});
}

class LoginEvent extends AuthEvent {
  final String name;
  final String password;
  LoginEvent({required this.name, required this.password});
}

class TryAutoLoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
