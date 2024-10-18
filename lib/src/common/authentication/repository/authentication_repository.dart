import 'dart:async';

import 'package:gchat/src/core/helpers/storage.helper.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

extension AuthenticationStatusX on AuthenticationStatus {
  bool get isAuthenticated => this == AuthenticationStatus.authenticated;
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  void setStatus(AuthenticationStatus status) {
    _controller.add(status);
  }

  void dispose() {
    _controller.close();
  }

  Future<void> logOut() async {
    StorageHelper.instance.removeUser();
    await StorageHelper.instance.removeToken();
    await StorageHelper.instance.removeNextResendTime();
    setStatus(AuthenticationStatus.unauthenticated);
  }
}
