// ignore_for_file: constant_identifier_names

enum ScareenType {
  LOGIN ,
  REGISTER,
}

extension ScreenTypeExt on ScareenType {
  bool get isLogin => this == ScareenType.LOGIN;
  bool get isRegister => this == ScareenType.REGISTER;
}