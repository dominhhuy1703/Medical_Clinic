import 'dart:convert'; // Để xử lý JSON
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://medical-clinic-api.vercel.app/api/v1';

  // Hàm để gửi yêu cầu đăng nhập
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      // Kiểm tra mã phản hồi (200 là thành công)
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['access'] != null) {
          // Đăng nhập thành công, trả về token và thông báo
          return {
            'status': 'success',
            'message': data['message'],
            'access': data['access'],
            'refresh': data['refresh'],
          };
        } else {
          // API không trả về token
          return {'status': 'error', 'message': 'Access token not found'};
        }
      } else {
        // Trường hợp mã lỗi không phải 200
        return {
          'status': 'error',
          'message': 'Failed to login: ${response.statusCode}',
          'details': json.decode(response.body),
        };
      }
    } catch (e) {
      // Lỗi kết nối hoặc lỗi bất thường
      throw Exception('Failed to connect to server: $e');
    }
  }
}
