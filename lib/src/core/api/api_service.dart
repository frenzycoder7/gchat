import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gchat/src/common/authentication/bloc/authentication_bloc.dart';
import 'package:gchat/src/core/api/api.enums.dart';
import 'package:gchat/src/core/api/api_helpers.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final bool _logs;
  AuthenticationBloc authBloc;
  ApiService({bool logs = false, required this.authBloc}) : _logs = logs;
  Future<String> getToken() async {
    return await ApiHelpers.instance.getToken();
  }

  final ApiResponse _networkError = ApiResponse(
    status: ResponseStatus.NETWORK_ERROR,
    message: 'Network Error! Please check your internet connection ',
    data: {},
  );

  Future<ApiResponse> get(String url, Map<String, String>? headers) async {
    Map<String, String> headers0 = await ApiHelpers.instance.getHeaders();
    if (headers != null) {
      headers0.addAll(headers);
    }
    bool isActive = await ApiHelpers.instance.networkStatus();
    if (!isActive) {
      return _networkError;
    }

    if (_logs) debugPrint('API: $url');
    if (_logs) debugPrint('Authorization: ${headers0['Authorization']}');

    return await ApiHelpers.instance.formatResponse(
      await http.get(Uri.parse(url), headers: headers0),
      _logs,
      authBloc,
    );
  }

  Future<ApiResponse> post({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    Map<String, String> headers0 = await ApiHelpers.instance.getHeaders();
    if (headers != null) {
      headers0.addAll(headers);
    }
    bool isActive = await ApiHelpers.instance.networkStatus();
    if (!isActive) {
      return _networkError;
    }

    if (_logs) debugPrint('API: $url');
    if (_logs) debugPrint('BODY: $body');
    return await ApiHelpers.instance.formatResponse(
      await http.post(
        Uri.parse(url),
        headers: headers0,
        body: body,
      ),
      _logs,
      authBloc,
    );
  }

  Future<ApiResponse> put(
    String url,
    Map<String, String>? headers,
    Map<String, dynamic> body,
  ) async {
    Map<String, String> headers0 = await ApiHelpers.instance.getHeaders();
    if (headers != null) {
      headers0.addAll(headers);
    }
    bool isActive = await ApiHelpers.instance.networkStatus();
    if (!isActive) {
      return _networkError;
    }

    if (_logs) debugPrint('API: $url');
    if (_logs) debugPrint('BODY: $body');
    return await ApiHelpers.instance.formatResponse(
      await http.put(
        Uri.parse(url),
        headers: headers0,
        body: body,
      ),
      _logs,
      authBloc,
    );
  }

  Future<ApiResponse> delete(String url, Map<String, String>? headers) async {
    Map<String, String> headers0 = await ApiHelpers.instance.getHeaders();
    if (headers != null) {
      headers0.addAll(headers);
    }
    bool isActive = await ApiHelpers.instance.networkStatus();
    if (!isActive) {
      return _networkError;
    }

    if (_logs) debugPrint('API: $url');
    return await ApiHelpers.instance.formatResponse(
      await http.delete(Uri.parse(url), headers: headers0),
      _logs,
      authBloc,
    );
  }

  Future<ApiResponse> patch(
    String url,
    Map<String, String>? headers,
    Map<String, dynamic> body,
  ) async {
    Map<String, String> headers0 = await ApiHelpers.instance.getHeaders();
    if (headers != null) {
      headers0.addAll(headers);
    }
    bool isActive = await ApiHelpers.instance.networkStatus();
    if (!isActive) {
      return _networkError;
    }

    if (_logs) debugPrint('API: $url');
    if (_logs) debugPrint('BODY: $body');
    return await ApiHelpers.instance.formatResponse(
      await http.patch(
        Uri.parse(url),
        headers: headers0,
        body: body,
      ),
      _logs,
      authBloc,
    );
  }

  Future<bool> uploadImage(String url, String imagePath) async {
    File file = File(imagePath);
    Uint8List byte = await file.readAsBytes();

    bool isActive = await ApiHelpers.instance.networkStatus();
    if (!isActive) {
      return throw Exception("Internet connection is not available");
    }

    if (_logs) debugPrint('API: $url');
    if (_logs) debugPrint('BODY: $byte');
    http.Response res = await http.put(
      Uri.parse(url),
      body: byte,
    );

    return res.statusCode == 200;
  }
}
