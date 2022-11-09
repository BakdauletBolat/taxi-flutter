import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseInterceptor extends Interceptor {}

class AuthInterceptor extends BaseInterceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    options.headers['Authorization'] = 'Bearer $token';
    return super.onRequest(options, handler);
  }
}
