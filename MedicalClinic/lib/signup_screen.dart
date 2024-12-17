import 'package:flutter/material.dart';
import 'package:medical_clinic/service/auth_repository.dart';
import 'verify_email_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthRepository _authRepository = AuthRepository();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Color primaryColor = Color(0xFF1F2B6C);
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final Map<String, dynamic> userData = {
      "first_name": _firstNameController.text.trim(),
      "last_name": _lastNameController.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _phoneController.text.trim(),
      "address": _addressController.text.trim(),
      "password": _passwordController.text.trim(),
      "role_id": 4,
    };

    try {
      final response = await _authRepository.registerUser(userData);

      final String verificationCode = response['code'];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyEmailScreen(code: verificationCode),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Đăng ký thất bại: ${error.toString()}"),
          backgroundColor: Colors.red,
        ),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Chào mừng đến với\nMEDICAL CLINIC',
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
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(labelText: 'Họ'),
                    validator: (value) => value!.isEmpty ? 'Vui lòng nhập họ' : null,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(labelText: 'Tên'),
                    validator: (value) => value!.isEmpty ? 'Vui lòng nhập tên' : null,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty || !value.contains('@')
                        ? 'Vui lòng nhập email hợp lệ'
                        : null,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Số điện thoại'),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty ? 'Vui lòng nhập số điện thoại' : null,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Địa chỉ'),
                    validator: (value) => value!.isEmpty ? 'Vui lòng nhập địa chỉ' : null,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) => value!.length < 6 ? 'Mật khẩu ít nhất 6 ký tự' : null,
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white,)
                        : Text('Đăng ký',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Đã có tài khoản? Đăng nhập',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
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
