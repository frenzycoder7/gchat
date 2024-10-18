import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gchat/src/common/authentication/repository/authentication_repository.dart';
import 'package:gchat/src/core/helpers/network.helper.dart';

extension BlocExt on Bloc {
  Future<bool> checkNetworkStatus() async {
    return await NetworkHelper.isNetworkAvailable();
  }

  void authenticate(AuthenticationRepository repository) {
    repository.setStatus(AuthenticationStatus.authenticated);
  }

  void unauthenticate(AuthenticationRepository repository) {
    repository.setStatus(AuthenticationStatus.unauthenticated);
  }
  
}
