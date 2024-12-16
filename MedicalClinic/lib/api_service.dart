import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'token_provider.dart';
import 'package:flutter/material.dart';

class ApiService {
  static const String baseUrl = 'https://medical-clinic-api.vercel.app/api/v1';

  // Hàm để gửi yêu cầu đăng nhập
  static Future<Map<String, dynamic>> login(String email, String password, BuildContext context) async {
    final url = Uri.parse('$baseUrl/auth/login/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['access'] != null) {
          // Lưu token và userId vào TokenProvider
          final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
          tokenProvider.setToken(data['access']);
          tokenProvider.setUserId(data['user_id']);

          print("Login success - User ID: ${data['user_id']}");
          print("Login success - Access token: ${data['access']}");

          return {
            'status': 'success',
            'message': data['message'],
            'access': data['access'],
            'refresh': data['refresh'],
            'user_id': data['user_id'],
          };
        } else {
          return {'status': 'error', 'message': 'Access token not found'};
        }
      } else {
        return {
          'status': 'error',
          'message': 'Failed to login: ${response.statusCode}',
          'details': json.decode(response.body),
        };
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  // Hàm lấy thông tin User đã đăng nhập
  static Future<Map<String, dynamic>> getLoggedInUserInfo(BuildContext context) async {
    final userId = Provider.of<TokenProvider>(context, listen: false).user_id;
    if (userId == null) {
      throw Exception('User ID không tồn tại, vui lòng đăng nhập lại.');
    }

    final url = Uri.parse('$baseUrl/users/$userId/');
    print("Gọi đến URL: $url");

    final token = Provider.of<TokenProvider>(context, listen: false).token;
    if (token.isEmpty) {
      throw Exception('Token không hợp lệ hoặc chưa đăng nhập');
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Phản hồi từ API $url: ${response.statusCode}");
      print("Phản hồi body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = json.decode(decodedResponse);
        return data;
      } else {
        throw Exception('Failed to load user info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Hàm lấy danh sách appointment theo userId
  static Future<List<Map<String, dynamic>>> getAppointmentsByUserId(BuildContext context) async {
    final userId = Provider.of<TokenProvider>(context, listen: false).user_id;
    if (userId == null) {
      throw Exception('User ID không tồn tại, vui lòng đăng nhập lại.');
    }

    final url = Uri.parse('$baseUrl/appointment/?user_id=$userId');
    print("Gọi đến URL: $url");

    final token = Provider.of<TokenProvider>(context, listen: false).token;
    if (token == null || token.isEmpty) {
      throw Exception('Token không hợp lệ hoặc chưa đăng nhập');
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Phản hồi từ API $url: ${response.statusCode}");
      print("Phản hồi body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = json.decode(decodedResponse);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Failed to load appointments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Hàm lấy medical-record theo userId
  static Future<List<Map<String, dynamic>>> getMedicalRecordsByUserId(BuildContext context) async {
    final userId = Provider.of<TokenProvider>(context, listen: false).user_id;
    if (userId == null) {
      throw Exception('User ID không tồn tại, vui lòng đăng nhập lại.');
    }

    final url = Uri.parse('$baseUrl/medical-record/?user_id=$userId');
    print("Gọi đến URL: $url");

    final token = Provider.of<TokenProvider>(context, listen: false).token;
    if (token == null || token.isEmpty) {
      throw Exception('Token không hợp lệ hoặc chưa đăng nhập');
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Phản hồi từ API $url: ${response.statusCode}");
      print("Phản hồi body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = json.decode(decodedResponse);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Failed to load medical records: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Hàm lấy danh sách khoa từ API với Authorization Header
  static Future<List<Map<String, dynamic>>> getDepartments(BuildContext context) async {
    final url = Uri.parse('$baseUrl/department/');
    print("Gọi đến URL: $url");

    final token = Provider.of<TokenProvider>(context, listen: false).token;

    if (token == null) {
      throw Exception('Token không hợp lệ hoặc chưa đăng nhập');
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = json.decode(decodedResponse);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Failed to load departments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Hàm lấy danh sách bác sĩ theo ID khoa
  static Future<List<Map<String, dynamic>>> getDoctorsByDepartment(int departmentId, BuildContext context) async {
    final url = Uri.parse('$baseUrl/doctor/?department=$departmentId');
    try {
      final token = Provider.of<TokenProvider>(context, listen: false).token;

      if (token == null) {
        throw Exception('Token không hợp lệ hoặc chưa đăng nhập');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = json.decode(decodedResponse);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Failed to load doctors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Hàm lấy thông tin khoa theo ID
  static Future<Map<String, dynamic>> getDepartmentById(int id, BuildContext context) async {
    final url = Uri.parse('$baseUrl/department/$id/');
    try {
      final token = Provider.of<TokenProvider>(context, listen: false).token;

      if (token == null) {
        throw Exception('Token không hợp lệ hoặc chưa đăng nhập');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = json.decode(decodedResponse);
        return data;
      } else {
        throw Exception('Failed to load department: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Hàm tạo lịch hẹn với ngày giờ kết hợp
  static Future<Map<String, dynamic>> createAppointment({
    required int doctorId, // Chuyển thành int
    required DateTime appointmentDate,
    String? status,
    required BuildContext context,
  }) async {
    final url = Uri.parse('$baseUrl/appointment/'); // API endpoint

    final token = Provider.of<TokenProvider>(context, listen: false).token;

    if (token.isEmpty) {
      throw Exception('Token không hợp lệ hoặc chưa đăng nhập.');
    }

    // Chuyển appointmentDate sang chuỗi ISO 8601
    final String appointmentDateIso = appointmentDate.toIso8601String();

    final Map<String, dynamic> requestBody = {
      'doctor_id': doctorId, // Truyền thẳng int
      'appointment_date': appointmentDateIso,
      'status': status ?? '',
    };

    print("===== Bắt đầu gọi API Tạo Lịch Hẹn =====");
    print("API URL: $url");
    print("Request Headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer $token' }");
    print("Request Body: ${jsonEncode(requestBody)}");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        print("Đặt lịch thành công!");
        return jsonDecode(response.body);
      } else {
        print("Đặt lịch thất bại - Status Code: ${response.statusCode}");
        print("Lý do thất bại: ${response.body}");
        throw Exception(
            'Failed to create appointment: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      print("Lỗi khi gọi API: $error");
      throw Exception('Error creating appointment: $error');
    } finally {
      print("===== Kết thúc gọi API Tạo Lịch Hẹn =====");
    }
  }
}
