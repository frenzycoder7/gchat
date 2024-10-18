part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
    this.isDark = true,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(MUser user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
  const AuthenticationState.changeTheme(
      bool isDark, AuthenticationStatus status, MUser? user)
      : this._(isDark: isDark, status: status, user: user);

  final AuthenticationStatus status;
  final MUser? user;
  final bool isDark;

  @override
  List<Object> get props => [status, isDark];
}
