import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gchat/src/common/authentication/model/user.model.dart';
import 'package:gchat/src/common/authentication/repository/authentication_repository.dart';
import 'package:gchat/src/core/api/api.enums.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/core/api/extension.api.dart';
import 'package:gchat/src/core/helpers/storage.helper.dart';
import 'package:gchat/src/modules/loginAndRegister/enums/enums.dart';
import 'package:gchat/src/modules/loginAndRegister/repository/loginAndRegister.repository.dart';

part 'login_and_register_event.dart';
part 'login_and_register_state.dart';

class LoginAndRegisterBloc
    extends Bloc<LoginAndRegisterEvent, LoginAndRegisterState> {
  LoginAndRegisterRepository repository;
  AuthenticationRepository authRepo;
  LoginAndRegisterBloc({
    required this.repository,
    required this.authRepo,
  }) : super(LoginAndRegisterState()) {
    on<ChangeScareenType>(_changeScreentype);
    on<ShowAndHidePassword>(_showHidePassword);
    on<LoginPageEvent>(_login);
    on<RegisterEvent>(_register);
  }

  Future<void> _changeScreentype(
    ChangeScareenType event,
    Emitter<LoginAndRegisterState> emit,
  ) async {
    emit(
      state.copyWith(
        scareenType: state.scareenType.isLogin
            ? ScareenType.REGISTER
            : ScareenType.LOGIN,
      ),
    );
  }

  Future<void> _showHidePassword(
    ShowAndHidePassword event,
    Emitter<LoginAndRegisterState> emit,
  ) async {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> _login(
    LoginPageEvent event,
    Emitter<LoginAndRegisterState> emit,
  ) async {
    String email = event.email;
    String password = event.password;
    bool isValid = _validate(email, password, null, true);
    if (isValid) {
      emit(state.copyWith(status: ResponseStatus.CALLING));
      if (state.rememberMe) {
        await repository.saveCredentials(email, password);
      }
      Pair<ApiResponse, MUser?> res = await repository.login(email, password);
      if (res.first.isSuccessful && res.last != null) {
        StorageHelper.instance.setUser(res.last as MUser);
        authRepo.setStatus(AuthenticationStatus.authenticated);
        emit(state.copyWith(status: res.first.status, user: res.last));
      } else {
        emit(state.copyWith(
            status: res.first.status, message: res.first.message));
      }
    } else {
      return;
    }
  }

  bool _validateEmail(String email) {
    bool isValid =
        (email.length > 6 && (email.contains('@')) && (email.contains('.')));
    if (!isValid) {
      Fluttertoast.showToast(msg: 'Please enter valid email address!');
    }

    return isValid;
  }

  bool _validatePassword(String password) {
    bool isValid = (password.length > 6);
    if (!isValid) {
      Fluttertoast.showToast(
          msg: 'Password must be at least 6 characters long!');
    }
    return isValid;
  }

  bool _validateName(String? name, bool isLogin) {
    if (isLogin) {
      return true;
    } else {
      if (name == null || name.isEmpty) {
        Fluttertoast.showToast(msg: 'Name must be at least 3 characters long!');
        return false;
      } else {
        return true;
      }
    }
  }

  bool _validate(String email, String password, String? name, bool isLogin) {
    return _validateName(name, isLogin) &&
        _validateEmail(email) &&
        _validatePassword(password);
  }

  Future<void> _register(
    RegisterEvent event,
    Emitter<LoginAndRegisterState> emit,
  ) async {
    if (_validate(event.email, event.password, event.name, false)) {
      emit(state.copyWith(status: ResponseStatus.CALLING));
      Pair<ApiResponse, MUser?> res =
          await repository.register(event.email, event.password, event.name);
      if (res.first.isSuccessful && res.last != null) {
        StorageHelper.instance.setUser(res.last as MUser);
        await StorageHelper.instance.saveToken(res.first.data['data']['token']);
        await StorageHelper.instance.saveNextResendTime();
        emit(state.copyWith(status: res.first.status, user: res.last));
      } else {
        emit(state.copyWith(
            status: res.first.status, message: res.first.message));
      }
    }
  }
}
