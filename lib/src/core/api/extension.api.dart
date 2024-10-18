import 'package:gchat/src/core/api/api.enums.dart';
import 'package:gchat/src/core/api/api_response.dart';

extension ApiResponseExt on ApiResponse {
  bool get isSuccessful =>
      status == ResponseStatus.SUCCESS || status == ResponseStatus.CREATED;
  bool get isError => status == ResponseStatus.ERROR;
  bool get isUnauthorized => status == ResponseStatus.UNAUTHORIZED;
  bool get isForbidden => status == ResponseStatus.FORBIDDEN;
  bool get isBadRequest => status == ResponseStatus.BAD_REQUEST;
  bool get isServerError => status == ResponseStatus.SERVER_ERROR;
  bool get isNetworkError => status == ResponseStatus.NETWORK_ERROR;
  bool get isNotFound => status == ResponseStatus.NOT_FOUND;
  bool get isUnknownError => status == ResponseStatus.UNKNOWN_ERROR;
}
