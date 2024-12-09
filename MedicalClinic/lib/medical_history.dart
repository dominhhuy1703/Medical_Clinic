import 'package:flutter/material.dart';
import 'home_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MedicalHistoryPage(),
    );
  }
}

class MedicalHistoryPage extends StatelessWidget {
  final List<Map<String, String>> appointments = [
    {
      'time': '15:30',
      'date': '06/03/2024',
      'room': 'Phòng khám: 202',
      'doctor': 'Bác sĩ: NDK',
      'specialty': 'Chuyên ngành: Tim',
    },
    {
      'time': '11:30',
      'date': '07/03/2024',
      'room': 'Phòng khám: 202',
      'doctor': 'Bác sĩ: NDK',
      'specialty': 'Chuyên ngành: Tim',
    },
    {
      'time': '11:30',
      'date': '07/03/2024',
      'room': 'Phòng khám: 202',
      'doctor': 'Bác sĩ: NDK',
      'specialty': 'Chuyên ngành: Tim',
    },
    {
      'time': '11:30',
      'date': '07/03/2024',
      'room': 'Phòng khám: 202',
      'doctor': 'Bác sĩ: NDK',
      'specialty': 'Chuyên ngành: Tim',
    },
  ];

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
              MaterialPageRoute(builder: (context) => HomeScreen ()),
            );
          },
        ),
        title: Text('Lịch sử khám bệnh',
        style: TextStyle(
          color: Color(0xFF1F2B6C),
        ),
      ),
      centerTitle: true,
      elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${appointment['time']}; ${appointment['date']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(appointment['room']!),
                Text(appointment['doctor']!),
                Text(appointment['specialty']!),
              ],
            ),
          );
        },
      ),
    );
  }
}
