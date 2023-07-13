import 'dart:io';

import 'package:cfl/controller/app/trip_service.dart';
import 'package:cfl/controller/auth/auth.dart';
import 'package:cfl/models/user.model.dart';
import 'package:cfl/shared/configs/url_config.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _auth = AuthService();
  AuthBloc() : super(const AuthState()) {
    on<AuthLogin>(_onLogin);
    on<AuthRegister>(_onRegister);
    on<AuthGoogle>(_onGoogleSignIn);
    on<AuthGoogleAuthorization>(_onGoogleSignInAuthorization);
    on<AuthProfileUpdate>(_onUserUpdate);
    on<AuthGetProfile>(_onUserProfile);
    on<AuthPasswordReset>(_onPasswordReset);
    on<AuthConfirmPasswordReset>(_onConfirmPasswordReset);
    on<AuthPasswordUpdate>(_onPasswordUpdate);
    on<AuthProfilePictureUpload>(_onProfilePictureUplaod);
    on<AuthDeleteAccount>(_onDeleteAccount);
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

      final profile = await _auth.getUser(accessToken: token);
      await _auth.saveToLocalStorage(key: 'token', value: token);
      await _auth.saveToLocalStorage(key: 'user', value: profile.toRawJson());

      accessToken = token;
      currentUser = profile;
      currentLocation = (await TripService().getCurrentLocation())!;
      emit(state.copyWith(status: AuthStatus.authenticated, token: token));
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }

  void _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _auth.register(
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
      final profile = await _auth.getUser(accessToken: token);
      await _auth.saveToLocalStorage(key: 'token', value: token);
      await _auth.saveToLocalStorage(key: 'user', value: profile.toRawJson());
      accessToken = token;
      currentUser = profile;
      emit(
        state.copyWith(status: AuthStatus.registered, user: profile),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }

  void _onGoogleSignIn(AuthGoogle event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _auth.signInWithGoogle(
        clientId: Platform.isAndroid ? androidClientId : iosClientId,
      );
      //emit(state.copyWith(status: AuthStatus.authenticated, token: auth));
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }

  void _onGoogleSignInAuthorization(
      AuthGoogleAuthorization event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final token = await _auth.handleTokenRequest(
        code: event.code,
        clientId: Platform.isAndroid ? androidClientId : iosClientId,
        clientSecret:
            Platform.isAndroid ? androidClientSecret : iosClientSecret,
      );
      final data = JwtDecoder.decode(token);

      await _auth.register(
        subject: token,
        email: data['email'],
        password: '123456',
        name: data['name'],
      );
      final profile = await _auth.getUser(accessToken: token);
      accessToken = token;
      currentUser = profile;
      // userId = id;
      emit(state.copyWith(status: AuthStatus.authenticated, token: token));
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

  void _onUserProfile(AuthGetProfile event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final profile = await _auth.getUser(accessToken: event.token);
      final profilePic = await _auth.getProfilePictureUrl(
          id: event.id, accessToken: accessToken);
      currentUser = profile;
      currentProfilePic = profilePic.url;
      emit(
        state.copyWith(
            status: AuthStatus.userProfile,
            user: profile,
            profilePic: profilePic.url),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }

  void _onDeleteAccount(
      AuthDeleteAccount event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _auth.deleteUser(accessToken: event.token, id: event.id);

      emit(
        state.copyWith(
          status: AuthStatus.deleteAccount,
        ),
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
        email: event.email,
      );
      emit(
        state.copyWith(status: AuthStatus.passwordRest),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }

  void _onConfirmPasswordReset(
      AuthConfirmPasswordReset event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _auth.confirlResetPassword(
        code: event.code,
        newPassword: event.newPassword,
      );
      emit(
        state.copyWith(status: AuthStatus.confirmPasswordRest),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }

  void _onProfilePictureUplaod(
      AuthProfilePictureUpload event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final url = await auth.getUrlToUploadProfilePicture(
          id: event.id, accessToken: event.token);

      await auth.uploadProfilePicture(
          url: Uri.parse(url.url), imageBytes: event.imageByte);
      final picture = await auth.getProfilePictureUrl(
          id: event.id, accessToken: event.token);
      emit(
        state.copyWith(
            status: AuthStatus.profilePicture, profilePic: picture.url),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AuthStatus.error));
    }
  }
}
