import 'package:dio/dio.dart';
import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  AuthRepository() : super(endpoint: '/api/v1/auth');

  Future<dynamic> registerUser(Map<String, dynamic> userData) async {
    return await post('/register/', data: userData);
  }

  Future<dynamic> verifyEmail(String verificationCode) async {
    return await post('/verify_email/?p=$verificationCode');
  }

  Future<dynamic> loginUser(Map<String, dynamic> data) async {
    return await post('/login/', data: data);
  }

  Future<dynamic> verifyLoginCode(Map<String, dynamic> data) async {
    return await post('/login/verify_code', data: data);
  }

  Future<dynamic> forgotPassword(Map<String, dynamic> data) async {
    return await post('/reset_password/', data: data);
  }

  Future<dynamic> resetPassword(Map<String, dynamic> data) async {
    return await put('/password-reset-complete/', data: data);
  }

  Future<dynamic> logout(String refreshToken) async {
    try {
      final response = await dio.post(
        '$baseUrl/logout/',
        data: {'refresh': refreshToken},
      );
      return response.data;
    } on DioException catch (error) {
      throw handleError(error);
    }
  }
}
