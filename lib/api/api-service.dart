// ignore_for_file: file_names

import 'package:dio/dio.dart' show BaseOptions, Dio;
import 'package:taxizakaz/api/interceptor.dart';
import 'dart:io' show Platform;

class ApiService {
  Dio authApi = Dio()..interceptors.add(AuthInterceptor());
  Dio api = Dio(BaseOptions(
    baseUrl: Platform.isAndroid
        ? 'http://192.168.18.142:8000/api'
        : 'http://192.168.18.142:8000/api',
  ))
    ..interceptors.add(BaseInterceptor());

  ApiService() {
    authApi.options.baseUrl = Platform.isAndroid
        ? 'http://192.168.18.142:8000/api'
        : 'http://192.168.18.142:8000/api';
  }
}
