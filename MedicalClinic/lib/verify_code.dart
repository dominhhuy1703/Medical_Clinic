import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:medical_clinic/service/auth_repository.dart'; // Thêm đường dẫn đến file AuthRepository
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;

  const VerificationCodeScreen({required this.email, Key? key}) : super(key: key);

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;

  final AuthRepository _authRepository = AuthRepository();

  Future<void> verifyLoginCode(String code) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authRepository.verifyLoginCode({
        'email': widget.email,
        'code': code,
      });

      print('API Response: $response');  // Log toàn bộ phản hồi API để debug

      // Kiểm tra xem email và access token có trùng khớp với dữ liệu đã gửi không
      if (response['email'] == widget.email && response.containsKey('access')) {
        // Lưu access token nếu kiểm tra thành công
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', response['access']);
        await prefs.setString('refresh_token', response['refresh']);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Xác minh thành công!')),
        );

        // Chuyển hướng đến màn hình chính
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Nếu email hoặc access không khớp, thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mã xác minh không đúng hoặc email không khớp!')),
        );
      }
    } on DioException catch (e) {
      // Xử lý lỗi API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: ${e.message}')),
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
      appBar: AppBar(
        title: const Text('Xác minh mã'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mã xác minh đã được gửi đến email: ${widget.email}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập mã xác minh',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                final verificationCode = _codeController.text;
                if (verificationCode.isNotEmpty) {
                  verifyLoginCode(verificationCode);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vui lòng nhập mã xác minh!')),
                  );
                }
              },
              child: const Text('Xác minh'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
