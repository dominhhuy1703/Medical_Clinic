import 'package:flutter/material.dart';

class DoctorDetailPage extends StatelessWidget {
  final Map<String, String> doctor;

  DoctorDetailPage({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          doctor['name']!,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1F2B6C),
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
            ClipOval(
              child: Image.asset(
                doctor['image']!,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tên bác sĩ: ${doctor['name']}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Chuyên khoa: ${doctor['specialty']}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              'Đánh giá: ${doctor['rating']} (${doctor['reviews']})',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Kinh nghiệm: 10 năm',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              'Giá: 200000VNĐ',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              'Thời gian khám: Thứ 2 - Thứ 6, từ 9:00 AM đến 5:00 PM',
              style: TextStyle(fontSize: 18),
            ),

          ],
        ),
      ),
    );
  }
}
