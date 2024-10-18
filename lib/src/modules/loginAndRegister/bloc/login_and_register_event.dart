part of 'login_and_register_bloc.dart';

@immutable
sealed class LoginAndRegisterEvent {}
class ChangeScareenType extends LoginAndRegisterEvent {}

class ShowAndHidePassword extends LoginAndRegisterEvent {}

class LoginPageEvent extends LoginAndRegisterEvent {
  final String email;
  final String password;
  LoginPageEvent({
    required this.email,
    required this.password,
  });
}

class RegisterEvent extends LoginAndRegisterEvent {
  final String name;
  final String email;
  final String password;
  RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class RememberMeEvent extends LoginAndRegisterEvent {}
