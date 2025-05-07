import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as network;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payhive/constants/urls.dart';
import 'package:payhive/services/di/di.dart';
import 'package:payhive/services/network/api_result.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/widgets/snackbar.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Network {
  final network.Dio _dio;
  static final String _baseUrl = URLs.baseURl;

  Network()
      : _dio = network.Dio()
          ..options = network.BaseOptions(
            baseUrl: _baseUrl,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          ..interceptors.addAll([
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
            ),
            network.InterceptorsWrapper(
              onRequest: (options, handler) => handler.next(options),
            ),
          ]);

  getData({
    Map<String, dynamic>? queryParameters,
    required String endPoint,
  }) async {
    if (kDebugMode) {
      debugPrint(token);
    }

    try {
      final response = await _dio.get(
        _baseUrl + endPoint,
        queryParameters: queryParameters,
      );
      return returnResponse(response);
    } on SocketException {
      return ApiFailure('Socket Exception');
    } on FormatException {
      return ApiFailure('Format Exception');
    } on network.DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiFailure('Unexpected Error');
    }
  }

  Future<ApiResults> postData({
    dynamic data,
    required String endPoint,
  }) async {
    try {
      final response = await _dio.post(
        endPoint,
        data: network.FormData.fromMap(data ?? {}),
      );
      return returnResponse(response);
    } on SocketException {
      return ApiFailure('Socket Exception');
    } on FormatException {
      return ApiFailure('Format Exception');
    } on network.DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiFailure('Unexpected Error');
    }
  }


  Future<ApiResults> postDataWithJson({
    dynamic data,
    required String endPoint,
  }) async {
    try {
      final response = await _dio.post(
        endPoint,
        data: json.encode(data ?? {}),
      );
      return returnResponse(response);
    } on SocketException {
      return ApiFailure('Socket Exception');
    } on FormatException {
      return ApiFailure('Format Exception');
    } on network.DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiFailure('Unexpected Error');
    }
  }

  postDataWithFilesNew(
      {Map<String, dynamic>? data,
      required String endPoint,
      required network.FormData formData,
      callback}) async {
    try {
      final response = await _dio.post(
        _baseUrl + endPoint,
        queryParameters: data,
        data: formData,
        onSendProgress: (int sent, int total) {
          double percent = sent / total * 100;
          percentage = percent.toString().split(".").first;
          debugPrint('UPLOADED - ${percent.toString().split(".").first}');
          callback;
        },
      );

      return returnResponse(response);
    } on SocketException {
      return ApiFailure('Socket Exception');
    } on FormatException {
      return ApiFailure('Format Exception');
    } on network.DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiFailure('Unexpected Error');
    }
  }

  ApiResults returnResponse(network.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        debugPrint(response.toString());

        debugPrint(response.data.runtimeType.toString());

        if (response.data is String) {
          return ApiSuccess(
            json.decode(response.data),
            response.statusCode,
          );
        } else if (response.data is Map<String, dynamic> ||
            response.data is List) {
          return ApiSuccess(
            response.data,
            response.statusCode,
          );
        } else {
          return ApiFailure(
              title: 'Unexpected Response Data.',
              response.data
                  .toString()
                  .replaceAll("{", "")
                  .replaceAll("}", "")
                  .replaceAll(":", "")
                  .replaceAll("[", "")
                  .replaceAll("]", "")
                  .replaceAll("errors", "")
                  .replaceAll("error", "")
                  .trim());
        }
      case 400:
        return ApiFailure(
            title: "Bad request.",
            response.data
                .toString()
                .replaceAll("{", "")
                .replaceAll("}", "")
                .replaceAll(":", "")
                .replaceAll("[", "")
                .replaceAll("]", "")
                .replaceAll("errors", "")
                .replaceAll("error", "")
                .trim());
      case 401:
        return ApiFailure(
            title: "Incorrect credentials.",
            response.data
                .toString()
                .replaceAll("{", "")
                .replaceAll("}", "")
                .replaceAll(":", "")
                .replaceAll("[", "")
                .replaceAll("]", "")
                .replaceAll("errors", "")
                .replaceAll("error", "")
                .trim());
      case 403:
        return ApiFailure(
            title: "Token error.",
            response.data
                .toString()
                .replaceAll("{", "")
                .replaceAll("}", "")
                .replaceAll(":", "")
                .replaceAll("[", "")
                .replaceAll("]", "")
                .replaceAll("errors", "")
                .replaceAll("error", "")
                .trim());
      case 404:
        return ApiFailure("Resource not found.");
      case 422:
        return ApiFailure(
            title: "Bad  response",
            response.data
                .toString()
                .replaceAll("{", "")
                .replaceAll("}", "")
                .replaceAll(":", "")
                .replaceAll("[", "")
                .replaceAll("]", "")
                .replaceAll("errors", "")
                .replaceAll("error", "")
                .trim());
      case 500:
        return ApiFailure("Internal server error.");
      default:
        return ApiFailure(
          'Error occurred while communicating with server. StatusCode: ${response.statusCode}.',
        );
    }
  }

  ApiResults _handleDioError(network.DioException e) {
    if (e.response != null) {
      return returnResponse(e.response!);
    } else {
      switch (e.type) {
        case network.DioExceptionType.connectionTimeout:
          return ApiFailure('Connection Timeout');
        case network.DioExceptionType.receiveTimeout:
          return ApiFailure('Receive Timeout');
        case network.DioExceptionType.connectionError:
          showSnackBar(
            message: "Something went wrong, PLease try after some time",
            title: "Error",
            color: Colors.red,
          );
          return ApiFailure('No Internet');
        default:
          return ApiFailure('Unknown Error: ${e.message}');
      }
    }
  }
}
