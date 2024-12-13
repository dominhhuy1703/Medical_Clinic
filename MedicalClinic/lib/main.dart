import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'token_provider.dart';
import 'success_screen.dart';
import 'booking_schedule.dart';
import 'information_personal.dart';
import 'medical_history.dart';
import 'service_clinic.dart';
import 'online_consultation.dart';
import 'specialties_screen.dart';
import 'profile.dart';
import 'notifications.dart';
import 'contact.dart';
import 'medical_records.dart';
import 'forgot_password.dart';
import 'reset_password.dart';

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
          '/appointment':(context) => BookingPage(),
          '/personal_info': (context) => UserInfoScreen(),
          '/medical_history': (context) => MedicalHistoryPage(),
          '/service': (context) => ServiceClinicScreen(),
          '/online_consult': (context) => OnlineConsultationScreen(),
          '/specialties': (context) => SpecialityScreen(),
          '/profile': (context) => ProfilePage(),
          '/notifications': (context) => NotificationsPage(),
          '/contact': (context) => ContactPage(),
          '/medical_records': (context) => MedicalRecordsPage (),
          '/forgot_password': (context) => ForgotPasswordScreen(),
          '/reset_password': (context) => PasswordResetScreen(),
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
