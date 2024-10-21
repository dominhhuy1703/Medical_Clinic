import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xin chào Huy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              '👋 Xin chào Huy Đỗ',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildHomeTile(
                    context,
                    'Thông tin cá nhân',
                    'assets/personal_info.png', // Replace with correct asset
                  ),
                  _buildHomeTile(
                    context,
                    'Đặt lịch khám',
                    'assets/appointment.png', // Replace with correct asset
                  ),
                  _buildHomeTile(
                    context,
                    'Chỉ số sức khỏe', 'assets/health_metrics.png'),
                  _buildHomeTile(
                    context,
                    'Lịch sử khám', 'assets/medical_history.png'),
                  _buildHomeTile(
                    context,
                    'Tư vấn online', 'assets/online_consult.png'),
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildHomeTile(BuildContext context, String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: Image.asset(imagePath, width: 50, height: 50),
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          onTap: () {
            // Add navigation or actions based on tile tap
          },
        ),
      ),
    );
  }
}
