import 'package:flutter/material.dart';
import 'package:medical_clinic/login_screen.dart';

class EmailVerifiedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 50,
                color: Colors.green,
              ),
              SizedBox(height: 20),
              Text(
                'Xác Nhận Email Thành Công!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Cảm ơn bạn đã xác nhận email. Tài khoản của bạn đã được kích hoạt thành công.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Đăng Nhập'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,  // Changed from 'primary' to 'backgroundColor'
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
