import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'information_personal.dart';
import 'medical_history.dart';
import 'medical_records.dart';
import 'contact.dart';

class PersonalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1F2B6C),
        title: Text(
          'Thông tin cá nhân',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Thông tin cá nhân',
              style: TextStyle(fontSize: 16, color: Color(0xFF1F2B6C)),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF1F2B6C)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserInfoScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Lịch sử khám bệnh',
              style: TextStyle(fontSize: 16, color: Color(0xFF1F2B6C)),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF1F2B6C)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MedicalHistoryPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Hồ sơ bệnh án',
              style: TextStyle(fontSize: 16, color: Color(0xFF1F2B6C)),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF1F2B6C)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MedicalRecordsPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Liên hệ',
              style: TextStyle(fontSize: 16, color: Color(0xFF1F2B6C)),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF1F2B6C)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Đăng xuất',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            trailing: Icon(Icons.logout, color: Colors.red),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
