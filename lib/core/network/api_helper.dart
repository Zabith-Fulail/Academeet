import 'dart:convert';
import 'dart:developer';



import 'package:dio/dio.dart';

import '../../error/exceptions.dart';
import '../../features/data/data_sources/local_data_sources.dart';
import '../../features/data/models/response/error_response_model.dart';
import '../../utils/app_constants.dart';

class ApiHelper {
  final Dio dio;
  final LocalDataSource source;

  ApiHelper({required this.dio,required this.source}) {
    dio.options
      ..baseUrl = "http://52.221.206.194/"
      ..connectTimeout = const Duration(seconds: AppConstants.connectionTimeout)
      ..receiveTimeout = const Duration(seconds: AppConstants.connectionTimeout)
      ..headers = {
        "Content-Type": "application/json",
        "Authorization" : "Bearer ${source.getAccessToken()}",
        "Accept": "*/*",
      };
    dio.interceptors.addAll(
      [InterceptorsWrapper(
        onRequest: (options, handler) {
          log("➡️ REQUEST [${options.method}] => PATH: ${options.path}");
          if (options.data != null) {
            log("Request Body: ${_prettyJson(options.data)}");
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log("Response Body: ${_prettyJson(response.data)}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log("❌ ERROR [${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
          if (e.response?.data != null) {
            log("Error Body: ${_prettyJson(e.response?.data)}");
          } else {
            log("Error: ${e.message}");
          }
          return handler.next(e);
        },
      ),
        LogInterceptor(requestBody: false, responseBody: false),
      ]

    );
  }

  String _prettyJson(dynamic data) {
    try {
      return jsonEncode(data);
    } catch (e) {
      return data.toString();
    }
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    return await dio.get(path, queryParameters: queryParams);
  }

  Future<Response> post(String path, {dynamic data}) async {
    try{
      return await dio.post(path, data: data);
    } on DioException catch(e){
      log("DioException => ${e.message}");
      throw ServerException(ErrorResponseModel(errorDescription: e.message));
    }

  }

  Future<Response> put(String path, {dynamic data}) async {
    return await dio.put(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) async {
    return await dio.delete(path, data: data);
  }
}
