import 'package:flutter/material.dart';
import 'appointment_overall.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DoctorSelectionPage(),
    );
  }
}

class DoctorSelectionPage extends StatelessWidget {
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
              MaterialPageRoute(builder: (context) => AppointmentPage()),
            );
          },
        ),
        title: Text(
          'Chọn thông tin bác sĩ',
          style: TextStyle(
            color: Color(0xFF1F2B6C),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm bác sĩ',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  DoctorCard(
                    name: 'Nhi',
                    specialty: 'Khoa Nhi',
                    rating: 4.5,
                    reviews: 135,
                    imageUrl: 'assets/doctor1.png',

                  ),
                  DoctorCard(
                    name: 'Nhân',
                    specialty: 'Khoa Chỉnh hình',
                    rating: 4.3,
                    reviews: 130,
                    imageUrl: 'assets/doctor2.png',
                  ),
                  DoctorCard(
                    name: 'Ngọc',
                    specialty: 'Khoa Sản',
                    rating: 4.5,
                    reviews: 135,
                    imageUrl: 'assets/doctor3.png',
                  ),
                  DoctorCard(
                    name: 'Sally',
                    specialty: 'Khoa Tiêu hoá',
                    rating: 4.3,
                    reviews: 130,
                    imageUrl: 'assets/doctor4.png',
                  ),
                  DoctorCard(
                    name: 'Huy',
                    specialty: 'Khoa Thần kinh',
                    rating: 4.3,
                    reviews: 130,
                    imageUrl: 'assets/doctor4.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                /////
                ///// edit
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F2B6C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              child: Text(
                'Chọn thời gian',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String imageUrl;

  DoctorCard({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imageUrl),
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              specialty,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow[700], size: 16),
                SizedBox(width: 4),
                Text(
                  '$rating ($reviews reviews)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
