import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Color primaryColor = Color(0xFF1F2B6C);
  bool _obscurePassword = true;  // State to toggle password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  'Đăng ký',
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
                SizedBox(height: 20),
                // Full Name Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Họ và tên',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // Phone Field - only allows number input
                TextField(
                  keyboardType: TextInputType.number,  // Chỉ cho phép nhập số
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // Password Field - with visibility toggle
                TextField(
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
                      // Handle sign up logic
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Đăng ký',
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
                    // Navigate back to Login Screen
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Đã có tài khoản? Đăng nhập',
                    style: TextStyle(color: primaryColor),
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
