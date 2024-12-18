import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatelessWidget {
  static const Color primaryColor = Color(0xFF1F2B6C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Liên hệ',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Corrected icon color
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 20),

              _buildContactItem(
                icon: FontAwesomeIcons.phone,
                label: 'Khẩn cấp:',
                content: '(237) 681-812-255\n(237) 666-331-894',
              ),
              SizedBox(height: 16),


              _buildContactItem(
                icon: FontAwesomeIcons.mapMarkerAlt,
                label: 'Địa chỉ:',
                content: '0123 Hải Phòng\n9876 Lê Duẩn',
              ),
              SizedBox(height: 16),

              _buildContactItem(
                icon: FontAwesomeIcons.envelope,
                label: 'Email:',
                content: 'medical@gmail.com',
              ),
              SizedBox(height: 16),

              _buildContactItem(
                icon: FontAwesomeIcons.clock,
                label: 'Giờ làm việc:',
                content: 'Từ thứ hai đến thứ bảy: 09:00 - 20:00\nChỉ khẩn cấp vào Chủ nhật',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to create each contact item
  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: primaryColor, // Primary color for icons
          size: 28, // Increased size for better visibility
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18, // Slightly larger text for labels
                ),
              ),
              SizedBox(height: 6),
              Text(
                content,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16, // Adjusted content text size
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
