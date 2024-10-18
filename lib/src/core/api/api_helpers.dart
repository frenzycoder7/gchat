import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gchat/src/common/authentication/bloc/authentication_bloc.dart';
import 'package:gchat/src/common/extensions/string.extension.dart';
import 'package:gchat/src/core/api/api.enums.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/core/api/extension.api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelpers {
  static ApiHelpers instance = ApiHelpers._internal();
  factory ApiHelpers() {
    return instance;
  }
  ApiHelpers._internal();

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? 'NOT_FOUND';
  }

  Future<void> removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
  }

  Future<void> setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }

  Future<Map<String, String>> getHeaders() async {
    String token = await getToken();
    if (token.isNotFound) {
      return {};
    }
    return {
      'authorization': 'Bearer $token',
    };
  }

  Future<ApiResponse> formatResponse(
      http.Response response, bool logs, AuthenticationBloc authBloc) async {
    if (logs) {
      debugPrint(
          'statusCode: ${response.statusCode}, \ndata: ${response.body}');
    }

    dynamic res = json.decode(response.body);
    if (response.statusCode == 401) await removeToken();
    switch (response.statusCode) {
      case 200:
        return ApiResponse(
          status: ResponseStatus.SUCCESS,
          message: 'Success',
          data: res,
        );
      case 201:
        return ApiResponse(
          status: ResponseStatus.SUCCESS,
          message: 'Entry created on server',
          data: res,
        );
      case 400:
        String message = res['message'] ?? 'NOT_FOUND';
        return ApiResponse(
          status: ResponseStatus.BAD_REQUEST,
          message: message.isNotFound ? 'Bad Request' : message,
          data: res,
        );

      case 401:
        {
          authBloc.add(AuthenticationLogoutRequested());
          String message = res['message'] ?? 'NOT_FOUND';
          return ApiResponse(
            status: ResponseStatus.UNAUTHORIZED,
            message: message.isNotFound ? 'Unauthorized' : message,
            data: res,
          );
        }

      case 403:
        String message = res['message'] ?? 'NOT_FOUND';
        return ApiResponse(
          status: ResponseStatus.FORBIDDEN,
          message: message.isNotFound ? 'Forbidden' : message,
          data: res,
        );

      case 404:
        String message = res['message'] ?? 'NOT_FOUND';
        return ApiResponse(
          status: ResponseStatus.NOT_FOUND,
          message: message.isNotFound ? 'Not Found' : message,
          data: res,
        );

      case 500:
        String message = res['message'] ?? 'NOT_FOUND';
        return ApiResponse(
          status: ResponseStatus.SERVER_ERROR,
          message: message.isNotFound ? 'Server Error' : message,
          data: res,
        );

      default:
        String message = res['message'] ?? 'NOT_FOUND';
        return ApiResponse(
          status: ResponseStatus.UNKNOWN_ERROR,
          message: message.isNotFound ? 'Unknown Error' : message,
          data: res,
        );
    }
  }

  Future<bool> networkStatus() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> saveCredentials(String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', email);
    preferences.setString('password', password);
    return true;
  }

  Future<Map<String, String>> getCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = preferences.getString('email') ?? '';
    String password = preferences.getString('password') ?? '';
    return {
      'email': email,
      'password': password,
    };
  }
}
