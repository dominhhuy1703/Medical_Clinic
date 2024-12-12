import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'token_provider.dart';
import 'notifications.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of pages corresponding to each tab
  final List<Widget> _pages = [
    HomePage(),
    NotificationsPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final token = Provider.of<TokenProvider>(context).token;

    Color primaryColor = Color(0xFF1F2B6C);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _selectedIndex == 0
          ? AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '👋 Xin chào!',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
          ),
        ],
      )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Người dùng',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(height: 60),
          Expanded(
            child: ListView(
              children: [
                _buildHomeTile(
                  context,
                  'Đặt lịch khám',
                  'assets/appointment.png',
                  '/appointment',
                ),
                _buildHomeTile(
                  context,
                  'Dịch vụ phòng khám',
                  'assets/health_metrics.png',
                  '/service',
                ),
                _buildHomeTile(
                  context,
                  'Chuyên khoa',
                  'assets/medical_history.png',
                  '/specialties',
                ),
                _buildHomeTile(
                  context,
                  'Tư vấn online',
                  'assets/online_consult.png',
                  '/online_consult',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTile(BuildContext context, String title, String imagePath, String route) {
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
              Navigator.pushNamed(context, route);
            },
          ),
        ),
      ),
    );
  }
}
