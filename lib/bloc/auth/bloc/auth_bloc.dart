import 'dart:io';

import 'package:cfl/controller/auth/auth.dart';
import 'package:cfl/models/user.model.dart';
import 'package:cfl/shared/configs/url_config.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _auth = AuthService();
  AuthBloc() : super(const AuthState()) {
    on<AuthLogin>(_onLogin);
    on<AuthRegister>(_onRegister);
    on<AuthProfileUpdate>(_onUserUpdate);
    on<AuthPasswordReset>(_onPasswordReset);
    on<AuthPasswordUpdate>(_onPasswordUpdate);
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final token = await _auth.login(
        email: event.email,
        password: event.password,
        clientId: Platform.isAndroid ? androidClientId : iosClientId,
        clientSecret:
            Platform.isAndroid ? androidClientSecret : iosClientSecret,
      );

      emit(state.copyWith(status: AuthStatus.authenticated, token: token));
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }

  void _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await _auth.register(
        email: event.email,
        password: event.password,
        subject: event.subject,
        name: event.name,
      );
      final token = await _auth.login(
        email: event.email,
        password: event.password,
        clientId: Platform.isAndroid ? androidClientId : iosClientId,
        clientSecret:
            Platform.isAndroid ? androidClientSecret : iosClientSecret,
      );
      accessToken = token;
      emit(
        state.copyWith(status: AuthStatus.registered, user: user),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }

  void _onUserUpdate(AuthProfileUpdate event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await _auth.updateUser(
        userUpdate: event.userProfile,
        userId: event.id,
        accessToken: event.token,
      );
      currentUser = user;
      emit(
        state.copyWith(status: AuthStatus.profileUpdated, user: user),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }

  void _onPasswordUpdate(
      AuthPasswordUpdate event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _auth.updatePassword(
        accessToken: event.token,
        newPassword: event.newPassword,
        oldPassword: event.oldPassword,
      );
      emit(
        state.copyWith(status: AuthStatus.profileUpdated),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }

  void _onPasswordReset(
      AuthPasswordReset event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _auth.resetPassword(
        accessToken: event.token,
        email: event.email,
      );
      emit(
        state.copyWith(status: AuthStatus.passwordRest),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }
}
