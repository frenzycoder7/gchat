import 'package:gchat/src/common/enums/page_status.enums.dart';

extension CustomPageStatus on PageStatus {
  bool get isIdle => this == PageStatus.IDLE;
  bool get isLoading => this == PageStatus.LOADING;
  bool get isLoaded => this == PageStatus.LOADED;
  bool get isError => this == PageStatus.ERROR;
  bool get isNetworkError => this == PageStatus.NETWORK_ERROR;
  bool get isUnAuthorized => this == PageStatus.UN_AUTHORIZED;
  bool get isOther => this == PageStatus.OTHER;
}
