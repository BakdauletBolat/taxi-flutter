import 'package:dio/dio.dart';
import 'package:taxiflutter/api/interceptor.dart';

class ApiService {
  Dio authApi = Dio()..interceptors.add(AuthInterceptor());
  Dio api = Dio(BaseOptions(
    baseUrl: 'http://127.0.0.1:8000/api',
  ));

  ApiService() {
    authApi.options.baseUrl = 'http://127.0.0.1:8000/api';
  }
}
