import 'package:assignment12_front_end/logic/services/token_manager.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await TokenManager.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
