import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_clinic/service/auth_repository.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String? _message;
  String? _error;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1))],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Đặt lại mật khẩu',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF1F2B6C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Nhập mật khẩu mới',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1F2B6C), // Sử dụng backgroundColor thay cho primary
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : Text(
                      'Đặt lại mật khẩu',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (_message != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _message!,
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
                    ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _error!,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    final password = _passwordController.text.trim();
    final queryParams = Uri.parse(Uri.base.toString()).queryParameters;
    final uidb64 = queryParams['uidb64'];
    final token = queryParams['token'];

    if (password.isEmpty) {
      setState(() {
        _error = 'Vui lòng nhập mật khẩu mới.';
        _message = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _message = null;
    });

    try {
      // Khởi tạo đối tượng AuthRepository trước khi gọi phương thức resetPassword
      final authRepository = AuthRepository();
      final response = await authRepository.resetPassword({'password': password, 'uidb64': uidb64, 'token': token});

      if (response['success']) {
        setState(() {
          _message = 'Mật khẩu đã được thay đổi thành công.';
          _error = null;
        });
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/login');
        });
      } else {
        setState(() {
          _error = 'Đã xảy ra lỗi khi đặt lại mật khẩu. Vui lòng thử lại.';
          _message = null;
        });
      }
    } catch (err) {
      setState(() {
        _error = 'Đã xảy ra lỗi khi đặt lại mật khẩu. Vui lòng thử lại.';
        _message = null;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
