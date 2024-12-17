import 'package:flutter/material.dart';
import 'api_service.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late Future<Map<String, dynamic>> _userInfoFuture;
  Map<String, dynamic>? _userInfo; // Lưu thông tin người dùng
  bool _isEditing = false; // Biến điều khiển chế độ chỉnh sửa

  // Controller cho các trường chỉnh sửa
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _userInfoFuture = ApiService.getLoggedInUserInfo(context);
  }

  void _initializeControllers() {
    _controllers = {
      'first_name': TextEditingController(text: _userInfo?['first_name'] ?? ''),
      'last_name': TextEditingController(text: _userInfo?['last_name'] ?? ''),
      'phone': TextEditingController(text: _userInfo?['phone'] ?? ''),
      'date_of_birth': TextEditingController(text: _userInfo?['date_of_birth'] ?? ''),
      'gender': TextEditingController(text: _userInfo?['gender'] ?? ''),
      'address': TextEditingController(text: _userInfo?['address'] ?? ''),
      'insurance_number': TextEditingController(text: _userInfo?['insurance_number'] ?? ''),
      'id_card': TextEditingController(text: _userInfo?['id_card'] ?? ''),
      'ethnicity': TextEditingController(text: _userInfo?['ethnicity'] ?? ''),
      'job': TextEditingController(text: _userInfo?['job'] ?? ''),
    };
  }

  void _saveChanges() {
    setState(() {
      // Cập nhật _userInfo từ controllers
      _controllers.forEach((key, controller) {
        _userInfo?[key] = controller.text;
      });
      _isEditing = false; // Thoát chế độ chỉnh sửa
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Thông tin đã được cập nhật')),
    );
  }

  @override
  void dispose() {
    // Giải phóng controllers
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1F2B6C),
        title: Text(
          'Thông tin cá nhân',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                setState(() {
                  _isEditing = true; // Bật chế độ chỉnh sửa
                });
                _initializeControllers();
              },
            ),
          if (_isEditing)
            IconButton(
              icon: Icon(Icons.save, color: Colors.white),
              onPressed: _saveChanges, // Lưu các thay đổi
            ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Không có dữ liệu.'));
          }

          // Gán dữ liệu vào _userInfo nếu chưa có
          _userInfo ??= snapshot.data!;
          _initializeControllers();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildField('Họ', 'first_name'),
                _buildField('Tên', 'last_name'),
                _buildField('Điện thoại', 'phone'),
                _buildField('Ngày sinh', 'date_of_birth'),
                _buildField('Giới tính', 'gender'),
                _buildField('Địa chỉ', 'address'),
                Divider(),
                Text(
                  'Thông tin bổ sung',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _buildField('Mã BHYT', 'insurance_number'),
                _buildField('Số CMND/CCCD', 'id_card'),
                _buildField('Dân tộc', 'ethnicity'),
                _buildField('Nghề nghiệp', 'job'),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget cho từng trường thông tin
  Widget _buildField(String label, String field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: _isEditing
                ? TextField(
              controller: _controllers[field],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
            )
                : Text(
              _userInfo?[field] ?? '--',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
