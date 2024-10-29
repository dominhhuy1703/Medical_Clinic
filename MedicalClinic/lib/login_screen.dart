import 'package:flutter/material.dart';
import 'signup_screen.dart';  // Import the SignUpScreen
import 'home_screen.dart';  // Import the HomeScreen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Sample credentials
  final String correctPhone = '0942322419';
  final String correctPassword = '170302';

  Color primaryColor = Color(0xFF1F2B6C);
  bool _obscurePassword = true;  // State to toggle password visibility

  // Login logic
  void _login(BuildContext context) {
    String email = _phoneController.text;
    String password = _passwordController.text;

    if (email == correctPhone && password == correctPassword) {
      // Navigate to HomeScreen if credentials are correct
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Show an error message if credentials are incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid phone or password')),
      );
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
                  Container(
                    height: 250,
                    child: Image.asset(
                      'assets/img1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Phone Field - only allows number input
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,  // Chỉ cho phép nhập số
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Password Field - with visibility toggle
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,  // Bật tắt che mật khẩu
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off  // Biểu tượng khi che mật khẩu
                              : Icons.visibility,     // Biểu tượng khi hiển thị mật khẩu
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;  // Bật tắt hiển thị mật khẩu
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 350,  // Chiều rộng tùy chỉnh
                    height: 55,  // Chiều cao tùy chỉnh
                    child: ElevatedButton(
                      onPressed: () {
                        _login(context);  // Xử lý logic đăng nhập
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Sign Up Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      'Chưa có tài khoản? Đăng ký',
                      style: TextStyle(color: primaryColor),
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
