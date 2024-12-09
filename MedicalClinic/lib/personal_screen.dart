import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonalScreen extends StatelessWidget {
  final Color primaryColor = Color(0xFF1F2B6C);

  final TextEditingController nameController = TextEditingController(text: "Do Minh Huy");
  final TextEditingController emailController = TextEditingController(text: "dominhhuy1703@gmail.com");
  final TextEditingController phoneController = TextEditingController(text: "0942322419");
  final TextEditingController passwordController = TextEditingController(text: "170302");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Thông tin cá nhân",
          style: TextStyle(color: Colors.white, fontSize: 20), // Đặt màu chữ tiêu đề là trắng
        ),
        iconTheme: IconThemeData(color: Colors.white), // Đặt màu của icon Back là trắng
      ),
      body: SingleChildScrollView( // Cho phép cuộn nội dung
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/avatar.png'), // Đường dẫn ảnh avatar của bạn
              ),
              SizedBox(height: 15),
              Text("Chỉnh sửa ảnh", style: TextStyle(color: primaryColor, fontSize: 18)),
              SizedBox(height: 25),
              _buildTextField("Tên người dùng", nameController, fontSize: 18),
              SizedBox(height: 20),
              _buildTextField("Email", emailController, fontSize: 18),
              SizedBox(height: 20),
              _buildTextField("Số điện thoại", phoneController, fontSize: 16, isPhone: true),
              SizedBox(height: 20),
              _buildTextField("Mật khẩu", passwordController, fontSize: 18, isPassword: true),
              SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  // Hành động cập nhật
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  "Cập nhật",
                  style: TextStyle(color: Colors.white, fontSize: 18), // Đặt màu chữ là trắng
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false, bool isPhone = false, double fontSize = 14}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isPhone ? TextInputType.number : TextInputType.text,
      inputFormatters: isPhone ? [FilteringTextInputFormatter.digitsOnly] : [], // Chỉ cho phép nhập số nếu là Số điện thoại
      style: TextStyle(fontSize: fontSize),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: fontSize),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }
}
