import 'package:flutter/material.dart';
import 'personal_screen.dart';
import 'online_consultant.dart';
import 'medical_history.dart';
import 'appointment_overall.dart';
class HomeScreen extends StatelessWidget {
  Color primaryColor = Color(0xFF1F2B6C);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 60), // Khoảng cách phía trên dòng "Xin chào Huy Đỗ"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '👋 Xin chào Huy Đỗ',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/avatar.png'), // Thay thế bằng đường dẫn ảnh avatar đúng
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildHomeTile(
                    context,
                    'Thông tin cá nhân',
                    'assets/personal_info.png',
                  ),
                  _buildHomeTile(
                    context,
                    'Đặt lịch khám',
                    'assets/appointment.png',
                  ),
                  _buildHomeTile(
                    context,
                    'Chỉ số sức khỏe',
                    'assets/health_metrics.png',
                  ),
                  _buildHomeTile(
                    context,
                    'Lịch sử khám',
                    'assets/medical_history.png',
                  ),
                  _buildHomeTile(
                    context,
                    'Tư vấn online',
                    'assets/online_consult.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Chỉ số'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Lịch sử'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildHomeTile(BuildContext context, String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 3,
        child: Container(
          height: 70,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            leading: Image.asset(imagePath, width: 50, height: 50),
            title: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              if (title == 'Thông tin cá nhân') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalScreen(),
                  ),
                );
              }
              if (title == 'Tư vấn online') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnlineConsultationPage(),
                  ),
                );
              }
              if (title == 'Lịch sử khám') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicalHistoryPage(),
                  ),
                );
              }

              if (title == 'Đặt lịch khám') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentPage(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}