import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gchat/src/common/authentication/model/user.model.dart';
import 'package:gchat/src/common/authentication/repository/authentication_repository.dart';
import 'package:gchat/src/core/api/api.enums.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/core/helpers/storage.helper.dart';
import 'package:meta/meta.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthenticationRepository reporistory})
      : _repository = reporistory,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
    _authenticationStatusSubscription = _repository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status: status)),
    );

    on<ChangeUserDataAndAuthenticate>(
      (event, emit) {
        debugPrint('ChangeUserDataAndAuthenticate');
        emit(const AuthenticationState.unauthenticated());
        emit(AuthenticationState.authenticated(event.user));
      },
    );

    on<ChangeThemeEvent>(
      (event, emit) => emit(
        AuthenticationState.changeTheme(
            !state.isDark, state.status, state.user),
      ),
    );
  }

  late final StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  final AuthenticationRepository _repository;

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        MUser? user = StorageHelper.instance.user;
        if (user == null) {
          return emit(const AuthenticationState.unauthenticated());
        } else {
          emit(AuthenticationState.authenticated(user));
        }
        break;

      case AuthenticationStatus.unauthenticated:
        emit(const AuthenticationState.unauthenticated());
        break;

      case AuthenticationStatus.unknown:
        emit(const AuthenticationState.unknown());
        break;
    }
  }

  Future<void> _onLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    addError(
      ApiResponse(
        status: ResponseStatus.UNAUTHORIZED,
        message: 'Your token is expired please login again',
        data: {},
      ),
    );
    _repository.logOut();
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
