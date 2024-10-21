import 'package:flutter/material.dart';
import 'login_screen.dart';  // Import the LoginScreen
import 'signup_screen.dart'; // Import the SignUpScreen
import 'home_screen.dart'; // Import the HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  Color primaryColor = Color(0xFF1F2B6C);

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
                  'Chào mừng đến với',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Medical Clinic',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 400,
                  margin: EdgeInsets.symmetric(vertical: 20), // Thêm khoảng cách trên và dưới cho Container
                  child: Image.asset(
                    'assets/img1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 350, // Chiều rộng cố định
                  height: 55, // Chiều cao cố định
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center, // Căn giữa nội dung
                    ),
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center, // Đảm bảo văn bản căn giữa
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: 350, // Chiều rộng cố định
                  height: 55, // Chiều cao cố định
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      side: BorderSide(color: primaryColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center, // Căn giữa nội dung
                    ),
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center, // Đảm bảo văn bản căn giữa
                    ),
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
