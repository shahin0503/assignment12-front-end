import 'package:assignment12_front_end/logic/services/token_manager.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseURL = 'http://192.168.0.108:3000/api';
const Map<String, dynamic> defaultHeaders = {
  'Content-Type': 'application/json'
};

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = baseURL;
    _dio.options.headers = defaultHeaders;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final String? token = await TokenManager.getToken();

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
    ));
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
  });

  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
      success: data['success'],
      data: data['data'],
      message: data['message'] ?? 'Unexpected error',
    );
  }
}
