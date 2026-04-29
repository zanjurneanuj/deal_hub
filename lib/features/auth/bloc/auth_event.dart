abstract class AuthEvent {}

/// Triggered when user clicks login
class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  LoginSubmitted({
    required this.email,
    required this.password,
  });
}

/// Optional: logout event (for future use)
class LogoutRequested extends AuthEvent {}