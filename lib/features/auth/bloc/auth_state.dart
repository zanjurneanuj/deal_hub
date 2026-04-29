abstract class AuthState {}

/// Initial state
class AuthInitial extends AuthState {}

/// While processing login
class AuthLoading extends AuthState {}

/// Login success
class AuthSuccess extends AuthState {}

/// Login failed
class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}