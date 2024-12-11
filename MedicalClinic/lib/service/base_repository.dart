import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BaseRepository {
  final String baseUrl;
  final String endpoint;
  late final Dio dio;

  BaseRepository({required this.endpoint})
      : baseUrl = const String.fromEnvironment('BASE_URL', defaultValue: 'https://medical-clinic-api.vercel.app') {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    print('Base URL: $baseUrl');
    print('Endpoint: $endpoint');

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          const storage = FlutterSecureStorage();
          final token = await storage.read(key: 'auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print('Final Request URL: ${options.baseUrl}${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          print('API Error: ${error.response ?? error.message}');
          return handler.reject(handleError(error));
        },
      ),
    );
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get('$endpoint$path', queryParameters: params);
      return response.data;
    } catch (error) {
      throw handleError(error as DioException);
    }
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.post('$endpoint$path', data: data);
      return response.data;
    } catch (error) {
      throw handleError(error as DioException);
    }
  }

  Future<dynamic> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put('$endpoint$path', data: data);
      return response.data;
    } catch (error) {
      throw handleError(error as DioException);
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await dio.delete('$endpoint$path');
      return response.data;
    } catch (error) {
      throw handleError(error as DioException);
    }
  }

  DioException handleError(DioException error) {
    if (error.response != null) {
      return DioException(
        requestOptions: error.requestOptions,
        response: error.response,
        type: error.type,
        error: error.response?.data['message'] ?? 'Đã xảy ra lỗi từ server.',
      );
    } else if (error.type == DioExceptionType.connectionTimeout || error.type == DioExceptionType.receiveTimeout) {
      return DioException(
        requestOptions: error.requestOptions,
        type: DioExceptionType.connectionTimeout,
        error: 'Không nhận được phản hồi từ server.',
      );
    } else {
      return DioException(
        requestOptions: error.requestOptions,
        type: DioExceptionType.unknown,
        error: 'Lỗi: ${error.message}',
      );
    }
  }
}
