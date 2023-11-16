// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';

class HttpClient {
  Dio? dio;
  static final HttpClient _instance = HttpClient._internal();
  factory HttpClient() => _instance;

  HttpClient._internal() {
    var baseUrl = 'Your base url';
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 5000),
      headers: {
        HttpHeaders.acceptHeader: "accept: multipart/form-data",
        'X-Shopify-Access-Token': 'token'
      },
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
  }

  /// restful get
  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      var response = await dio!.get(
        path,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      print(e);
    }
  }

  /// restful post
  Future post(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    var response = await dio!.post(
      path,
      queryParameters: params,
      options: options,
    );
    return response.data;
  }

  /// restful delete
  Future delete(
    String path,
    Map<String, dynamic>? data, {
    Options? options,
  }) async {
    try {
      var response = await dio!.delete(
        path,
        queryParameters: data,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      print(e);
    }
  }

  /// restful put
  Future put(
    String path,
    Map<String, dynamic>? data, {
    Options? options,
  }) async {
    try {
      var response = await dio!.put(
        path,
        queryParameters: data,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      print(e);
    }
  }
}
