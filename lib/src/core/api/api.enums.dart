// ignore_for_file: constant_identifier_names

enum ResponseStatus {
  IDLE,
  CALLING,
  SUCCESS,
  CREATED,
  ERROR,
  NETWORK_ERROR,
  NOT_FOUND,
  UNAUTHORIZED,
  BAD_REQUEST,
  FORBIDDEN,
  SERVER_ERROR,
  UNKNOWN_ERROR,
}

extension ResponseStatusExt on ResponseStatus {
  bool get isIdle => this == ResponseStatus.IDLE; // status == 0
  bool get isCalling => this == ResponseStatus.CALLING; // status == 100
  bool get isSucess => this == ResponseStatus.SUCCESS; // status == 200
  bool get isCreated => this == ResponseStatus.CREATED; // status == 201
  bool get isError => this == ResponseStatus.ERROR; // status == 400
  bool get isNetworkError => this == ResponseStatus.NETWORK_ERROR; // status == 404
  bool get isNotFound => this == ResponseStatus.NOT_FOUND; // status == 404 || empty data  
  bool get isUnauthorized => this == ResponseStatus.UNAUTHORIZED; // status == 401
  bool get isBadRequest => this == ResponseStatus.BAD_REQUEST; // status == 500
  bool get isForbidden => this == ResponseStatus.FORBIDDEN; // status == 403
  bool get isServerError => this == ResponseStatus.SERVER_ERROR; // status == 500
  bool get isUnknownError => this == ResponseStatus.UNKNOWN_ERROR; // status == 500

  bool get isAnyError => isError || isNetworkError || isNotFound || isUnauthorized || isBadRequest || isForbidden || isServerError || isUnknownError;
}
