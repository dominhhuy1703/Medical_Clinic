import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoRow(label: 'Họ và tên', value: '--'),
            UserInfoRow(label: 'Điện thoại', value: '--'),
            UserInfoRow(label: 'Ngày sinh', value: '--'),
            UserInfoRow(label: 'Giới tính', value: '--'),
            UserInfoRow(label: 'Địa chỉ', value: '--'),
            Divider(),
            Text(
              'Thông tin bổ sung',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            UserInfoRow(label: 'Mã BHYT', value: '--'),
            UserInfoRow(label: 'Số CMND/CCCD', value: '--'),
            UserInfoRow(label: 'Dân tộc', value: '--'),
            UserInfoRow(label: 'Nghề nghiệp', value: '--'),
          ],
        ),
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
              style: TextStyle(fontSize: 16, color: Colors.black87), // Adjusted text color
            ),
          ),
        ],
      ),
    );
  }
}
