import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuestionPage(),
    );
  }
}

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  String? selectedSpecialty;
  String? selectedGender;
  String? selectedAgeGroup;
  TextEditingController questionController = TextEditingController();

  final List<String> specialties = ['Chuyên ngành 1', 'Chuyên ngành 2', 'Chuyên ngành 3'];
  final List<String> genders = ['Nam', 'Nữ', 'Khác'];
  final List<String> ageGroups = ['Dưới 18', 'Từ 18-35', 'Trên 35'];

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
          'Đặt câu hỏi',
          style: TextStyle(color: Color(0xFF1F2B6C), fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedSpecialty,
              items: specialties
                  .map((specialty) => DropdownMenuItem<String>(
                value: specialty,
                child: Text(specialty),
              ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Chọn chuyên ngành',
                labelStyle: TextStyle(color: Colors.black),

              ),
              onChanged: (value) {
                setState(() {
                  selectedSpecialty = value;
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedGender,
              items: genders
                  .map((gender) => DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Chọn giới tính',
                labelStyle: TextStyle(color: Colors.black),

              ),
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedAgeGroup,
              items: ageGroups
                  .map((ageGroup) => DropdownMenuItem<String>(
                value: ageGroup,
                child: Text(ageGroup),
              ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Chọn độ tuổi',
                labelStyle: TextStyle(color: Colors.black),

              ),
              onChanged: (value) {
                setState(() {
                  selectedAgeGroup = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: questionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Viết câu hỏi',
                labelStyle: TextStyle(color: Color(0xFF1F2B6C)),
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {


                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F2B6C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'Đặt câu hỏi',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
