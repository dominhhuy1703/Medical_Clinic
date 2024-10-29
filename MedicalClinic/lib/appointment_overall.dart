import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'doctor_selection.dart';
import 'medical_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppointmentPage(),
    );
  }
}

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: Text(
          'Đặt lịch khám',
          style: TextStyle(color: Color(0xFF1F2B6C), fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            OptionCard(
              title: 'Bác sĩ',
              image: 'assets/doctor_icon.png',
              color: Color(0xFFE5D9F2),//fixlaimau
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorSelectionPage()),
                );
              },
            ),
            SizedBox(height: 20),
            OptionCard(
              title: 'Dịch vụ y tế',
              image: 'assets/medical_service_icon.png',
              color: Color(0xFFE5D9F2),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServicePage()),
                );

              },
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final VoidCallback onPressed;

  OptionCard({
    required this.title,
    required this.image,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
