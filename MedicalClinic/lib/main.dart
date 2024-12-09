import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'token_provider.dart';
import 'success_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TokenProvider(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/success_email': (context) => EmailVerifiedScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final Color primaryColor = Color(0xFF1F2B6C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset(
                      'assets/img1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
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
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        side: BorderSide(color: primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
