import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../auth_api.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi authApi;
  AuthBloc({required this.authApi}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignUpEvent) {
        emit(LoadinggState());

        try {
          final userId = await authApi.auth(event.name, event.password, false);

          emit(LoginDoneState(userName: event.name, userId: userId));
        } catch (error) {
          emit(ErrorState(errorMessage: error.toString()));
        }
      } else if (event is LoginEvent) {
        emit(LoadinggState());

        try {
          final userId = await authApi.auth(event.name, event.password, true);

          emit(LoginDoneState(userName: event.name, userId: userId));
        } catch (error) {
          emit(ErrorState(errorMessage: error.toString()));
        }
      } else if (event is TryAutoLoginEvent) {
        emit(SplashState());
        final userData = await authApi.tryAutoLogin();
        if (userData != null) {
          emit(LoginDoneState(
              userName: userData['userName'], userId: userData['id']));
        } else {
          emit(AuthInitial());
        }
      } else if (event is LogoutEvent) {
        emit(SplashState());
        try {
          await authApi.logout();
          emit(AuthInitial());
        } catch (error) {
          emit(ErrorState(errorMessage: error.toString()));
        }
      }
    });
  }
}
