import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_service.dart';
import 'token_provider.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late Future<Map<String, dynamic>> _userInfoFuture;

  @override
  void initState() {
    super.initState();
    // Gọi API khi màn hình được khởi tạo
    _userInfoFuture = ApiService.getLoggedInUserInfo(context);
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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

          final userInfo = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoRow(label: 'Họ và tên', value: '${userInfo['first_name'] ?? ''} ${userInfo['last_name'] ?? ''}'),
                UserInfoRow(label: 'Điện thoại', value: userInfo['phone'] ?? '--'),
                UserInfoRow(label: 'Ngày sinh', value: userInfo['date_of_birth'] ?? '--'),
                UserInfoRow(label: 'Giới tính', value: userInfo['gender'] ?? '--'),
                UserInfoRow(label: 'Địa chỉ', value: userInfo['address'] ?? '--'),
                Divider(),
                Text(
                  'Thông tin bổ sung',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                UserInfoRow(label: 'Mã BHYT', value: userInfo['insurance_number'] ?? '--'),
                UserInfoRow(label: 'Số CMND/CCCD', value: userInfo['id_card'] ?? '--'),
                UserInfoRow(label: 'Dân tộc', value: userInfo['ethnicity'] ?? '--'),
                UserInfoRow(label: 'Nghề nghiệp', value: userInfo['job'] ?? '--'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
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
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
