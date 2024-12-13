import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:medical_clinic/service/auth_repository.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage;
  String? _successMessage;
  bool _isLoading = false;

  // Trạng thái lưu token
  bool _tokenValid = false;


  final AuthRepository _authRepository = AuthRepository();

  Future<void> _handleForgotPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Vui lòng nhập email của bạn.';
        _successMessage = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final response = await _authRepository.forgotPassword({'email': email});

      // Kiểm tra phản hồi API và lấy token cùng uidb64
      if (response.containsKey('message') &&
          response['message'] == 'We have sent you a link to reset your password') {
        setState(() {
          _successMessage = response['message'];
          _tokenValid = true;
          _errorMessage = null;
        });
      } else {
        setState(() {
          _errorMessage = 'Phản hồi từ máy chủ không hợp lệ. Vui lòng thử lại sau.';
          _successMessage = null;
        });
      }
    } catch (error) {
      if (error is DioException) {
        final statusCode = error.response?.statusCode;
        final errorData = error.response?.data;

        setState(() {
          if (statusCode == 400) {
            _errorMessage = errorData['detail'] ?? 'Email không hợp lệ hoặc không tồn tại.';
          } else if (statusCode == 500) {
            _errorMessage = 'Lỗi máy chủ. Vui lòng thử lại sau.';
          } else {
            _errorMessage = 'Đã xảy ra lỗi. Vui lòng kiểm tra kết nối mạng.';
          }
          _successMessage = null;
        });
      } else {
        setState(() {
          _errorMessage = 'Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.';
          _successMessage = null;
        });
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToResetPassword() {
    Navigator.pushReplacementNamed(
      context,
      '/reset_password',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Quên mật khẩu',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2B6C),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Nhập email của bạn để đặt lại mật khẩu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                SizedBox(height: 32.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Nhập email của bạn',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                if (_successMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      _successMessage!,
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleForgotPassword,
                  child: _isLoading
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text('Gửi yêu cầu đặt lại mật khẩu'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48.0),
                    backgroundColor: Color(0xFF1F2B6C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                if (_tokenValid)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton(
                      onPressed: _navigateToResetPassword,
                      child: Text('Tiếp tục'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.0),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Quay lại đăng nhập',
                    style: TextStyle(color: Color(0xFF1F2B6C)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
