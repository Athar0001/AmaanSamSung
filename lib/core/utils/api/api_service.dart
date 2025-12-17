import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:amaan_tv/core/utils/api/end_point.dart';
import 'package:amaan_tv/core/utils/cash_services/cashe_helper.dart';

class ApiService {
  ApiService._(this._dio);

  final Dio _dio;
  static ApiService? _instance;

  static ApiService getInstance() {
    if (_instance == null) {
      final options = BaseOptions(baseUrl: EndPoint.baseUrl);
      final dio = Dio(options);

      if (kDebugMode) {
        dio.interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true),
        );
      }

      (dio.httpClientAdapter as IOHttpClientAdapter).validateCertificate =
          (cert, host, port) => true;
      _instance = ApiService._(dio);
    }
    return _instance!;
  }

  Map<String, String> apiHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json, text/plain, */*',
  };

  bool isValidResponse(int statusCode) {
    return statusCode >= 200 && statusCode <= 302;
  }

  Future<Response> makePostRequest(
    String endPoint, {
    Object? postValues,
    Map<String, dynamic>? headers,
    bool withToken = true,
    bool isMultipart = false,
    bool isFormData = false,
    Map<String, dynamic>? query,
  }) async {
    return _makeRequest(
      endPoint,
      postValues: postValues,
      headers: headers,
      withToken: withToken,
      isMultipart: isMultipart,
      query: query,
      method: 'POST',
      isFormData: isFormData,
    );
  }

  Future<Response> makePutRequest(
    String endPoint, {
    Object? postValues,
    Map<String, dynamic>? headers,
    bool withToken = true,
    Map<String, dynamic>? query,
  }) async {
    return _makeRequest(
      endPoint,
      postValues: postValues,
      headers: headers,
      withToken: withToken,
      query: query,
      method: 'PUT',
    );
  }

  Future<Response> makeDeleteRequest(
    String endPoint, {
    Map<String, dynamic>? headers,
    Object? postValues,
    bool withToken = true,
    Map<String, dynamic>? query,
  }) async {
    return _makeRequest(
      endPoint,
      headers: headers,
      withToken: withToken,
      postValues: postValues,
      query: query,
      method: 'DELETE',
    );
  }

  Future<Response> makeGetRequest(
    String endPoint, {
    Map<String, dynamic>? headers,
    bool withToken = true,
    Map<String, dynamic>? query,
  }) async {
    return _makeRequest(
      endPoint,
      headers: headers,
      withToken: withToken,
      query: query,
      method: 'GET',
    );
  }

  Future<Response> _makeRequest(
    String endPoint, {
    required String method,
    Object? postValues,
    Map<String, dynamic>? headers,
    bool withToken = true,
    bool isMultipart = false,
    bool isFormData = false,
    Map<String, dynamic>? query,
  }) async {
    Response response;
    // try {
    FormData? formData;
    if (isFormData) {
      formData = FormData.fromMap(postValues as Map<String, dynamic>);
    }

    // Simplified locale header
    _dio.options.headers['Accept-Language'] =
        'ar'; // Defaulting to Arabic or can be dynamic if we have a provider

    if (withToken == true && CacheHelper.currentUser != null) {
      _dio.options.headers['Authorization'] =
          'Bearer ${CacheHelper.currentUser!.token}';
    } else {
      _dio.options.headers.removeWhere((key, value) => key == 'Authorization');
    }

    if (isMultipart) {
      _dio.options.headers['Content-Type'] = 'multipart/form-data';
    } else {
      _dio.options.headers['Content-Type'] = 'application/json';
    }
    if (headers != null) _dio.options.headers.addAll(headers);
    debugPrint('MakeRequest url is #$endPoint');
    debugPrint('MakeRequest body are #${postValues.toString()}');
    debugPrint('MakeGetRequest query is #$query');
    try {
      response = await _dio.request(
        endPoint,
        data: formData ?? postValues,
        queryParameters: query,
        options: Options(method: method),
      );
      debugPrint('MakeRequest done');
      return response;
    } on DioException catch (e) {
      log((e.response?.data).toString(), name: 'DioException');
      rethrow;
    }
  }
}
