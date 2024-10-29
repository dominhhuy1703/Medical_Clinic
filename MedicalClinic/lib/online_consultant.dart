import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnlineConsultationScreen(),
    );
  }
}
// addcauhoi
class OnlineConsultationScreen extends StatelessWidget {
  final List<String> questions = [
    'Cách ly F0 tại nhà?',
    'Cách để ăn nhiều mà vẫn gầy?',
    'Chữa bệnh lao phổi tại nhà?',
    'Cách cấp cứu nhanh khi cano bị lật?',
    'Chữa bệnh lao phổi tại nhà?',
    'Chữa bệnh lao phổi tại nhà?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Tư vấn online',
          style: TextStyle(color: Color(0xFF1F2B6C), fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Tìm câu hỏi',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.help_outline, color: Color(0xFF1F2B6C)),
                    title: Text(
                      questions[index],
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {

                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPaginationDot(isActive: true),
                SizedBox(width: 8),
                _buildPaginationDot(isActive: false),
                SizedBox(width: 8),
                _buildPaginationDot(isActive: false),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F2B6C),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Đặt câu hỏi',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  // build dot
  Widget _buildPaginationDot({required bool isActive}) {
    return CircleAvatar(
      radius: 5,
      backgroundColor: isActive ? Colors.black : Colors.grey,
    );
  }
}
