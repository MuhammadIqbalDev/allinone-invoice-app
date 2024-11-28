part of 'auth_bloc.dart';

enum AuthStates { register, login, forgotPass, none }

class AuthState {
  final AuthStates? currentState;
  final User? user;
  final bool? keepLoggedIn;
  final bool? isLoading;
  final bool? success;
  final Exception? exception;

  const AuthState({
    this.currentState,
    required this.user,
    required this.keepLoggedIn,
    required this.isLoading,
    this.success,
    required this.exception,
  });

  Map<String, dynamic> toMap() {
    log("Save to database : $keepLoggedIn $user");
    return user!=null ? <String, dynamic>{
      'user': keepLoggedIn ?? false ? user?.toMap() : null,
      'keepLoggedIn': keepLoggedIn,
    } : <String, dynamic>{
      'user': false ,
      'keepLoggedIn': false,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    log(" gettting storage   ${map.toString()}");
    return AuthState(
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      keepLoggedIn:
          map['keepLoggedIn'] != null ? map['keepLoggedIn'] as bool : null,
      exception: null,
      isLoading: null,
    );
  }
}

class InitialAuthState extends AuthState {
  const InitialAuthState()
      : super(
          currentState: AuthStates.none,
          user: null,
          keepLoggedIn: null,
          exception: null,
          isLoading: null,
        );
}
