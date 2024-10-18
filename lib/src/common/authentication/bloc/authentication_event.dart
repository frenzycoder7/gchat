part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class _AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;
  _AuthenticationStatusChanged({
    required this.status,
  });
}


final class AuthenticationLogoutRequested extends AuthenticationEvent {}

final class ChangeThemeEvent extends AuthenticationEvent {}

final class ChangeUserDataAndAuthenticate extends AuthenticationEvent {
  final MUser user;
  ChangeUserDataAndAuthenticate({
    required this.user,
  });
}