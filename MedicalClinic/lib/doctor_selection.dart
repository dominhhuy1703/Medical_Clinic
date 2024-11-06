import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'doctor_detail.dart';
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

class DoctorSelectionPage extends StatefulWidget {
  @override
  _DoctorSelectionPageState createState() => _DoctorSelectionPageState();
}

class _DoctorSelectionPageState extends State<DoctorSelectionPage> {
  List<Doctor> _allDoctors = [];
  List<Doctor> _filteredDoctors = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  Future<void> _loadDoctors() async {
    final String response = await rootBundle.loadString('assets/fakedata.json');
    final data = json.decode(response);
    List<Doctor> doctors = (data['doctor'] as List)
        .map((doctorData) => Doctor.fromJson(doctorData))
        .toList();

    setState(() {
      _allDoctors = doctors;
      _filteredDoctors = doctors;
    });
  }
//timkiemdoctor
  void _filterDoctors(String query) {
    List<Doctor> filteredList = _allDoctors.where((doctor) {
      return doctor.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredDoctors = filteredList;
    });
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


      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterDoctors,
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
              child: GridView.builder(
                itemCount: _filteredDoctors.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final doctor = _filteredDoctors[index];
                  return DoctorCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetailPage(doctor: doctor),
                        ),
                      );
                    },
                    name: doctor.name,
                    specialty: doctor.specialty,
                    rating: doctor.rating,
                    reviews: doctor.reviews,
                    imageUrl: doctor.imageUrl,
                  );
                },
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
  final VoidCallback onTap;

  DoctorCard({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
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
      ),
    );
  }
}
class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String imageUrl;
  final String? experience;
  final String? education;
  final List<String>? languages;
  final String? bio;
  final List<String>? treatmentAreas;
  final List<Map<String, String>>? availability;
  final Map<String, String>? contactInfo;

  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    this.experience,
    this.education,
    this.languages,
    this.bio,
    this.treatmentAreas,
    this.availability,
    this.contactInfo,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      specialty: json['specialty'],
      rating: json['rating'],
      reviews: json['reviews'],
      imageUrl: json['imageUrl'],
      experience: json['experience'],
      education: json['education'],
      languages: (json['languages'] as List<dynamic>?)?.cast<String>(),
      bio: json['bio'],
      treatmentAreas: (json['treatment_areas'] as List<dynamic>?)?.cast<String>(),
      availability: (json['availability'] as List<dynamic>?)
          ?.map((item) => Map<String, String>.from(item))
          .toList(),
      contactInfo: json['contact_info'] != null
          ? Map<String, String>.from(json['contact_info'])
          : null,
    );
  }
}
