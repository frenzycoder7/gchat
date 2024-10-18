import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:gchat/src/common/authentication/model/user.model.dart';
import 'package:gchat/src/core/api/api_helpers.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/core/api/api_service.dart';
import 'package:gchat/src/core/api/endpoints.dart';
import 'package:gchat/src/core/api/extension.api.dart';

class LoginAndRegisterRepository {
  ApiService _apiService;
  LoginAndRegisterRepository(ApiService apiService) : _apiService = apiService;

  Future<Pair<ApiResponse, MUser?>> login(
    String email,
    String password,
  ) async {
    final response = await _apiService.post(
        url: ApiEndpoints.LOGIN, body: {'email': email, 'password': password});
    if (response.isSuccessful) {
      MUser user = MUser.fromJSON(response.data['data']['user']);
      await ApiHelpers.instance.setToken(response.data['data']['token']);
      return Pair(response, user);
    } else {
      return Pair(response, null);
    }
  }

  Future<Pair<ApiResponse, MUser>> register(
    String email,
    String password,
    String name,
  ) async {
    final response = await _apiService.post(
        url: ApiEndpoints.SIGNUP,
        body: {'name': name, 'email': email, 'password': password});
    MUser user = MUser.fromJSON(response.data['data']);
    user.settoken(response.data['data']['token']);
    return Pair(response, user);
  }

  Future<bool> saveCredentials(String email, String password) async {
    return await ApiHelpers.instance.saveCredentials(email, password);
  }

  Future<Map<String, String>> getCredentials() async {
    return await ApiHelpers.instance.getCredentials();
  }

  Future<void> saveToken(String token) async {
    return await ApiHelpers.instance.setToken(token);
  }

  Future<String> getToken() async {
    return await ApiHelpers.instance.getToken();
  }
}
