import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aman/utils/shared_prefs_keys.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_utils.dart';

class WebService {
  static WebService _instance;

  static BuildContext context;

  static WebService get() {
    return _instance ?? WebService();
  }

  Future<Map<String, String>> getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "Authorization": "Bearer ${prefs.getString(SharedPrefsKeys.USER_TOKEN)}",
      "Accept": "application/json"
    };
  }

  HttpClientWithInterceptor client =
      HttpClientWithInterceptor.build(interceptors: [
    LoggerInterceptor(),
  ]);

  Future<Response> getRequest(String url) async {
    var response =
        await client.get(Uri.parse(url), headers: await getHeaders());
    if (response.statusCode == 401) {
      AppUtils.logout(context);
    }
    return response;
    return response;
  }

  Future<Response> postRequest(String url,
      { Map<String, dynamic> body}) async {
    print("URL: $url");
    print("Body: $body");
    try {
      var response = await client.post(Uri.parse(url),
          headers: await getHeaders(), body: body);
      if (response.statusCode == 401) {
        AppUtils.logout(context);
      }
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<Response> putRequest(String url,
      { Map<String, dynamic> body}) async {
    print("URLLLLLLLL: $url");

    var response = await client.put(Uri.parse(url),
        headers: await getHeaders(), body: body);
    return response;
  }

  Future<DIO.Response> dioPost(String url,
      { Map<String, dynamic> body, bool debug = false}) async {
    var dio = DIO.Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestBody: debug,
        responseBody: debug,
        responseHeader: false,
        error: debug,
        compact: debug,
        maxWidth: 90));

    dio.interceptors.add(DioLogInterceptor());

    try {
      var response = await dio.post(url,
          data: json.encode(body),
          options: DIO.Options(headers: await WebService.get().getHeaders()));
      return response;
    } on DIO.DioError catch (ex) {
      if (ex.type == DIO.DioErrorType.response) {
        if (ex.response?.statusCode == 401) {
          AppUtils.logout(context);
          return ex.response;
        } else {
          return ex.response;
        }
      } else if (ex.type == DIO.DioErrorType.other) {
        throw const SocketException("");
      } else {
        print(ex.message);
      }
    }
  }

  Future<DIO.Response> dioPostWithPlainResponse(String url,
      { Map<String, dynamic> body, bool debug = false}) async {
    var dio = DIO.Dio();
    dio.interceptors.add(PrettyDioLogger(

        requestBody: debug,
        responseBody: debug,
        responseHeader: false,
        error: debug,
        compact: debug,
        maxWidth: 90));

    dio.interceptors.add(DioLogInterceptor());

    DIO.FormData formData = DIO.FormData.fromMap(body);
    try {
      var response = await dio.post(url,
          data: formData,
          options: DIO.Options(
              headers: await WebService.get().getHeaders(),
              responseType: DIO.ResponseType.plain));
      if (response.statusCode == 401) {
        AppUtils.logout(context);
      }
      return response;
    } on DIO.DioError catch (ex) {
      if (ex.type == DIO.DioErrorType.response) {
        if (ex.response?.statusCode == 401) {
          AppUtils.logout(context);
        } else {
          return ex.response;
        }
      } else if (ex.type == DIO.DioErrorType.other) {
        throw const SocketException("");
      } else {
        print(ex.message);
      }
    }
  }

  Future<DIO.Response> dioPostDynamic(String url,
      {dynamic body, bool debug = false}) async {
    var dio = DIO.Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestBody: debug,
        responseBody: debug,
        responseHeader: false,
        error: debug,
        compact: debug,
        maxWidth: 90));

    dio.interceptors.add(DioLogInterceptor());

    try {
      var response = await dio.post(url,
          data: body,
          options: DIO.Options(headers: await WebService.get().getHeaders()));
      if (response.statusCode == 401) {
        AppUtils.logout(context);
      }
      return response;
    } on DIO.DioError catch (ex) {
      if (ex.type == DIO.DioErrorType.response) {
        if (ex.response?.statusCode == 401) {
          AppUtils.logout(context);
        } else {
          return ex.response;
        }
      } else if (ex.type == DIO.DioErrorType.other) {
        throw const SocketException("");
      } else {
        print(ex.message);
      }
    }
  }

  Future<DIO.Response> dioDelete(String url,
      {bool debug = false,  Object body}) async {
    var dio = DIO.Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestBody: debug,
        responseBody: debug,
        responseHeader: false,
        error: debug,
        compact: debug,
        maxWidth: 90));

    dio.interceptors.add(DioLogInterceptor());
    return await dio.delete(url,
        data: jsonEncode(body),
        options: DIO.Options(headers: await WebService.get().getHeaders()));
  }

  Future<DIO.Response> dioGet(String url,
      { Map<String, dynamic> params, bool debug = false}) async {
    var dio = DIO.Dio();
    dio.interceptors.add(DioLogInterceptor());

    if (debug) {
      dio.interceptors.add(PrettyDioLogger());
    }

    try {
      var response = await dio.get(url,
          queryParameters: params,
          options: DIO.Options(headers: await WebService.get().getHeaders()));

      if (response.statusCode == 401) {
        AppUtils.logout(context);
      }
      return response;
    } on DIO.DioError catch (ex) {
      if (ex.type == DIO.DioErrorType.response) {
        if (ex.response?.statusCode == 401) {
          AppUtils.logout(context);
        }
      } else if (ex.type == DIO.DioErrorType.other) {
        throw const SocketException("");
      } else {
        print(ex.message);
      }
    }
  }
}

class LoggerInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({ RequestData data}) async {
    print("----- Request -----");
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ ResponseData data}) async {
    print("----- Response -----");
    print(data.toString());
    return data;
  }
}
