import 'dart:developer';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../model/user.dart';
import '../../../services/firebase_service.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc(FirebaseService fb, )
      : super(const InitialAuthState()) {
    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthState(
        currentState: AuthStates.register,
        user: null,
        keepLoggedIn: null,
        exception: null,
        isLoading: false,
      ));
    });
    on<AuthEventShouldLogin>((event, emit) {
      emit(const AuthState(
        currentState: AuthStates.login,
        user: null,
        keepLoggedIn: null,
        exception: null,
        isLoading: false,
      ));
    });
    on<AuthEventShouldForgotPassword>((event, emit) {
      emit(const AuthState(
        currentState: AuthStates.forgotPass,
        user: null,
        keepLoggedIn: null,
        exception: null,
        isLoading: false,
      ));
    });
    on<AuthEventUpdateUser>((event, emit) {
      emit(AuthState(
        currentState: AuthStates.none,
        user: event.user,
        keepLoggedIn: state.keepLoggedIn,
        exception: null,
        isLoading: false,
      ));
    });
    on<AuthEventRegister>((event, emit) async {
      emit(const AuthState(
        currentState: AuthStates.register,
        user: null,
        keepLoggedIn: null,
        exception: null,
        isLoading: true,
      ));
      final user = event.user;
      final keepLoggedIn = event.keepLoggedIn;
      try {
        final createdUser = await fb.registerUser(user: user);
        emit(AuthState(
          currentState: AuthStates.none,
          user: createdUser,
          keepLoggedIn: keepLoggedIn,
          exception: null,
          isLoading: false,
        ));
      } on Exception catch (e) {
        emit(AuthState(
          currentState: AuthStates.register,
          user: null,
          keepLoggedIn: null,
          exception: e,
          isLoading: false,
        ));
      }
    });
    on<AuthEventForgetPassword>((event, emit) async {
      emit(const AuthState(
        currentState: AuthStates.forgotPass,
        user: null,
        keepLoggedIn: null,
        exception: null,
        isLoading: true,
      ));
      try {
        final email = event.email;
        final sent = await fb.forgotPassword(email: email);
        emit(AuthState(
          currentState: AuthStates.forgotPass,
          user: null,
          success: sent,
          keepLoggedIn: null,
          exception: null,
          isLoading: false,
        ));
      } on Exception catch (e) {
        emit(AuthState(
          currentState: AuthStates.forgotPass,
          user: null,
          keepLoggedIn: null,
          exception: e,
          isLoading: false,
        ));
      }
    });
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthState(
        currentState: AuthStates.login,
        user: null,
        keepLoggedIn: null,
        isLoading: true,
        exception: null,
      ));
      final email = event.email;
      final phoneNumber = event.phoneNumber;
      final password = event.password;
      final keepLoggedIn = event.keepLoggedIn;

      log("Keep me Logggggggggggggggggggggin : $keepLoggedIn");

      try {
        log("Before getting user........");
        final user = await fb.loginUser(
          email: email,
          phone: phoneNumber,
          password: password,
        );
        log("user in bloc : $user");
        emit(AuthState(
          currentState: AuthStates.none,
          user: user,
          keepLoggedIn: keepLoggedIn,
          exception: null,
          isLoading: false,
        ));
      } on Exception catch (e) {
        
        emit(AuthState(
          currentState: AuthStates.login,
          user: null,
          keepLoggedIn: null,
          exception: e,
          isLoading: false,
        ));
      }
    });
    on<AuthEventLogOut>((event, emit) async {
      // await storage.saveSelectedCashBook('');
      emit(const AuthState(
        currentState: AuthStates.login,
        user: null,
        keepLoggedIn: null,
        exception: null,
        isLoading: false,
      ));
      // emit(const InitialAuthState());
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
