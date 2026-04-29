import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/session_manager.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  /// 🔐 Login Logic
  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    await Future.delayed(const Duration(seconds: 1));

    if (event.email == "anuj@gmail.com" &&
        event.password == "123456") {

      await SessionManager.setLoggedIn(true); //  save session
      emit(AuthSuccess());

    } else {
      emit(AuthFailure("Invalid credentials"));
    }
  }
  /// 🚪 Logout Logic (optional)
  void _onLogoutRequested(
      LogoutRequested event,
      Emitter<AuthState> emit,
      ) {
    emit(AuthInitial());
  }
}