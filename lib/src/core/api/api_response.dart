import 'package:gchat/src/core/api/api.enums.dart';

class ApiResponse {
  final ResponseStatus status;
  final String message;
  final dynamic data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });
}
