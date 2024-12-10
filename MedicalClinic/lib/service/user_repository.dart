import 'package:dio/dio.dart';

class UserRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://medical-clinic-api.vercel.app/api/v1/users'));

  // Lấy danh sách người dùng
  Future<List<dynamic>> getUsers({Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get('', queryParameters: queryParameters);
      List<dynamic> users = response.data['results']; // Lấy danh sách người dùng
      return users;
    } catch (e) {
      throw Exception('Lỗi khi lấy danh sách người dùng: $e');
    }
  }

  // Lấy thông tin người dùng theo ID
  Future<Map<String, dynamic>> getUserById(String userId) async {
    try {
      final response = await _dio.get('/$userId/');
      return response.data; // Trả về thông tin người dùng theo ID
    } catch (e) {
      throw Exception('Lỗi khi lấy thông tin người dùng: $e');
    }
  }

  // Thiết lập token cho các yêu cầu API
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
