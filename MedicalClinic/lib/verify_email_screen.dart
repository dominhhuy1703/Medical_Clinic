import 'package:flutter/material.dart';
import 'package:medical_clinic/service/auth_repository.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String code;
  final AuthRepository _authRepository = AuthRepository();

  VerifyEmailScreen({required this.code});

  Future<void> _verifyEmail(BuildContext context) async {
    try {
      await _authRepository.verifyEmail(code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Xác thực email thành công!"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacementNamed(context, '/success_email');
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Xác thực email thất bại: ${error.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xác thực email'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chúng tôi đã gửi mã xác thực đến email của bạn.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _verifyEmail(context),
              child: Text('Xác thực email'),
            ),
          ],
        ),
      ),
    );
  }
}
