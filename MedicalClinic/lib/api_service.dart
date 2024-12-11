import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'token_provider.dart';
import 'package:flutter/material.dart';


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

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['access'] != null) {

          return {
            'status': 'success',
            'message': data['message'],
            'access': data['access'],
            'refresh': data['refresh'],
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

  // Hàm lấy danh sách khoa từ API với Authorization Header
  static Future<List<Map<String, dynamic>>> getDepartments(BuildContext context) async {
    final url = Uri.parse('$baseUrl/department/');
    print("Gọi đến URL: $url");

    // Lấy token từ TokenProvider
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
}
