import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'verify_code.dart';
import 'package:medical_clinic/service/auth_repository.dart';
import 'token_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Color primaryColor = Color(0xFF1F2B6C);
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Gọi AuthRepository để đăng nhập
      final authRepository = AuthRepository();
      final response = await authRepository.loginUser({
        'email': email,
        'password': password,
      });

      // Kiểm tra phản hồi từ API
      if (response != null && response.containsKey('access')) {
        final bool isSendCode = response['is_send_code'] ?? false;

        if (isSendCode) {
          // Chuyển hướng đến trang xác minh mã
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationCodeScreen(email: email),
            ),
          );
        } else {
          // Lưu token và chuyển đến HomeScreen
          Provider.of<TokenProvider>(context, listen: false)
              .setToken(response['access']);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      } else if (response != null && response.containsKey('message')) {
        // Trường hợp server trả về message báo lỗi
        final String errorMessage = response['message'];
        if (errorMessage.contains("Send code verify")) {
          // Chuyển tới trang xác minh nếu có thông báo gửi mã xác minh thành công
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationCodeScreen(email: email),
            ),
          );
        } else {
          throw Exception(errorMessage);
        }
      } else {
        throw Exception('Phản hồi không hợp lệ từ server');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thất bại: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Chào mừng bạn đến với\nMEDICAL CLINIC',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Email Field
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
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
}
