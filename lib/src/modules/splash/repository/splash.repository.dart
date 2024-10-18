import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/core/api/api_service.dart';
import 'package:gchat/src/core/api/endpoints.dart';

class SplashRepository {
  final ApiService _apiService;

  SplashRepository(ApiService apiService) : _apiService = apiService;

  Future<ApiResponse> validateUser() async {
    return await _apiService.get(ApiEndpoints.VALIDATE_TOKEN, null);
  }
}
