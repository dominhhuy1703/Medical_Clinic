import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'questions.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnlineConsultationPage(),
    );
  }
}

class OnlineConsultationPage extends StatefulWidget {
  @override
  _OnlineConsultationScreenState createState() => _OnlineConsultationScreenState();
}

class _OnlineConsultationScreenState extends State<OnlineConsultationPage> {
  late Future<List<String>> _questions;

  // Load data
  Future<List<String>> _loadQuestions() async {
    final String response = await rootBundle.loadString('assets/fakedata.json');
    final data = json.decode(response);
    List<String> questions = List<String>.from(data['questions']);
    return questions;
  }

  @override
  void initState() {
    super.initState();
    _questions = _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
              child: FutureBuilder<List<String>>(
                future: _questions,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading questions'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No questions available.'));
                  } else {
                    final questions = snapshot.data!;
                    return ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.help_outline, color: Color(0xFF1F2B6C)),
                          title: Text(
                            questions[index],
                            style: TextStyle(fontSize: 16),
                          ),
                          onTap: () {
                            //edit
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F2B6C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
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
}
