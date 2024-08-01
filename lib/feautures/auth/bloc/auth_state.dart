part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadinggState extends AuthState {}

final class ErrorState extends AuthState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}

final class LoginDoneState extends AuthState {
  final String userName;
  final int userId;
  LoginDoneState({required this.userName, required this.userId});
}

final class SplashState extends AuthState {}
