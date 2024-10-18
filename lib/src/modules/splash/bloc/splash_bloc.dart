import 'package:bloc/bloc.dart';
import 'package:gchat/src/common/authentication/model/user.model.dart';
import 'package:gchat/src/common/authentication/repository/authentication_repository.dart';
import 'package:gchat/src/common/enums/page_status.enums.dart';
import 'package:gchat/src/common/extensions/bloc.extension.dart';
import 'package:gchat/src/common/extensions/string.extension.dart';
import 'package:gchat/src/common/models/page_state.model.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/core/api/extension.api.dart';
import 'package:gchat/src/core/helpers/storage.helper.dart';
import 'package:gchat/src/modules/splash/repository/splash.repository.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

PageState _loadingState =
    const PageState(status: PageStatus.LOADING, message: '');
PageState _networkError = const PageState(
  status: PageStatus.NETWORK_ERROR,
  message: 'Network Error! Please check your internet connection.',
);
PageState _loadedState = PageState(status: PageStatus.LOADED, message: '');

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepository repository;
  final AuthenticationRepository authRepository;
  SplashBloc({
    required this.repository,
    required this.authRepository,
  }) : super(SplashState(pageState: _loadingState)) {
    on<SplashEvent>((event, emit) {});
    on<ValidateToken>(_validateToken);
  }

  Future<String> _getToken() async {
    return StorageHelper.instance.getToken();
  }

  Future<void> _validateToken(
    ValidateToken event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(progress: 10.0));
    bool isNetworkAvailable = await checkNetworkStatus();
    if (!isNetworkAvailable) {
      authRepository.setStatus(AuthenticationStatus.unauthenticated);
      emit(state.copyWith(pageState: _networkError, progress: 10.0));
    } else {
      emit(state.copyWith(pageState: _loadingState, progress: 30.0));
      String token = await _getToken();
      emit(state.copyWith(pageState: _loadingState, progress: 35.0));
      if (token.isNotFound) {
        authRepository.setStatus(AuthenticationStatus.unauthenticated);
        emit(state.copyWith(progress: 100.0, pageState: _loadedState));
      } else {
        emit(state.copyWith(pageState: _loadingState, progress: 40.0));
        ApiResponse response = await repository.validateUser();
        if (response.isSuccessful) {
          emit(state.copyWith(progress: 80.0, pageState: _loadingState));
          MUser user = MUser.fromJSON(response.data['data']['user']);
          StorageHelper.instance.setUser(user);
          authRepository.setStatus(AuthenticationStatus.authenticated);
          emit(state.copyWith(
            progress: 100.0,
            pageState: _loadedState,
            user: user,
          ));
        } else if (response.isUnauthorized) {
          authRepository.setStatus(AuthenticationStatus.unauthenticated);
          emit(state.copyWith(
            progress: 100.0,
            pageState: PageState(
              status: PageStatus.UN_AUTHORIZED,
              message: response.data['message'] ?? response.message,
            ),
          ));
        } else {
          authRepository.setStatus(AuthenticationStatus.authenticated);
          emit(state.copyWith(
            progress: 100.0,
            pageState: PageState(
              status: PageStatus.ERROR,
              message: response.data['message'] ?? response.message,
            ),
          ));
        }
      }
    }
  }
}
