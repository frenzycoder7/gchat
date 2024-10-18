part of 'login_and_register_bloc.dart';

@immutable
class LoginAndRegisterState extends Equatable {
  ScareenType scareenType = ScareenType.LOGIN;
  bool isPasswordVisible = false;
  ResponseStatus status;
  MUser? user;
  bool rememberMe = false;
  bool isLoggedIn = false;
  String message;

  LoginAndRegisterState({
    this.scareenType = ScareenType.LOGIN,
    this.isPasswordVisible = false,
    this.status = ResponseStatus.IDLE,
    this.user,
    this.rememberMe = false,
    this.isLoggedIn = false,
    this.message = '',
  });

  LoginAndRegisterState copyWith({
    ScareenType? scareenType,
    bool? isPasswordVisible,
    ResponseStatus? status,
    MUser? user,
    bool? rememberMe,
    bool? isLoggedIn,
    String? message,
  }) {
    return LoginAndRegisterState(
      scareenType: scareenType ?? this.scareenType,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      user: user ?? this.user,
      rememberMe: rememberMe ?? this.rememberMe,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        scareenType,
        isPasswordVisible,
        status,
        user,
        rememberMe,
        isLoggedIn,
        message,
      ];
}
