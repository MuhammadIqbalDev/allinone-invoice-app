part of 'auth_bloc.dart';


abstract class AuthEvent {}

class AuthEventRegister extends AuthEvent {
  final User user;
  final bool keepLoggedIn;

  AuthEventRegister({required this.user, required this.keepLoggedIn});
}

class AuthEventLogIn extends AuthEvent {
  final String? email;
  final int? phoneNumber;
  final String password;
  final bool keepLoggedIn;

  AuthEventLogIn({
    this.email,
    this.phoneNumber,
    required this.password,
    required this.keepLoggedIn,
  });
}

class AuthEventForgetPassword extends AuthEvent {
  final String email;
  AuthEventForgetPassword({required this.email});
}

class AuthEventShouldRegister extends AuthEvent {
  AuthEventShouldRegister();
}

class AuthEventShouldLogin extends AuthEvent {
  AuthEventShouldLogin();
}

class AuthEventShouldForgotPassword extends AuthEvent {
  AuthEventShouldForgotPassword();
}

class AuthEventLogOut extends AuthEvent {}

class AuthEventUpdateUser extends AuthEvent {
  final User user;

  AuthEventUpdateUser({required this.user});
}
