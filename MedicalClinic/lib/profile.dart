import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'token_provider.dart';
import 'home_screen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1F2B6C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.person,
                  title: 'Thông tin cá nhân',
                  route: '/personal_info',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Lịch khám bệnh',
                  route: '/medical_history',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.folder,
                  title: 'Hồ sơ bệnh án',
                  route: '/medical_records',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.info,
                  title: 'Thông tin phòng khám',
                  route: '/contact',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.logout,
                  title: 'Đăng xuất',
                  onTap: () {
                    _logout(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {
    required IconData icon,
    required String title,
    String? route,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF1F2B6C), size: 30),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: () {
        if (onTap != null) {
          onTap();
        } else if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }

  void _logout(BuildContext context) {
    Provider.of<TokenProvider>(context, listen: false).clearData();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
