// ignore_for_file: file_names

import 'package:dio/dio.dart' show BaseOptions, Dio;
import 'package:taxizakaz/api/interceptor.dart';
import 'dart:io' show Platform;

class ApiService {
  String urlApple = 'http://127.0.0.1:8000/api';
  Dio authApi = Dio()..interceptors.add(AuthInterceptor());
  Dio api = Dio();

  ApiService() {
    api.options.baseUrl = Platform.isAndroid ? urlApple : urlApple;
    authApi.options.baseUrl = Platform.isAndroid ? urlApple : urlApple;
  }
}
