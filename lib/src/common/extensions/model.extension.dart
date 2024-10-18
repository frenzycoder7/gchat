import 'package:gchat/src/common/enums/page_status.enums.dart';
import 'package:gchat/src/common/models/page_state.model.dart';

extension CustomPageState on PageState {
  bool get isIdle => status == PageStatus.IDLE;
  bool get isLoading => status == PageStatus.LOADING;
  bool get isLoaded => status == PageStatus.LOADED;
  bool get isError => status == PageStatus.ERROR;
  bool get isNetworkError => status == PageStatus.NETWORK_ERROR;
  bool get isUnAuthorized => status == PageStatus.UN_AUTHORIZED;
  bool get isOther => status == PageStatus.OTHER;
  bool get isAnyError => isError || isNetworkError || isUnAuthorized || isOther;
}
