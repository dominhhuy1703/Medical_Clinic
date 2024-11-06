import 'package:flutter/material.dart';
import 'appointment_overall.dart';
import 'dart:convert';
import 'doctor.dart';
import 'package:flutter/services.dart' show rootBundle;

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



class DoctorService {
  Future<List<Doctor>> fetchDoctors() async {
    //final response = await http.get(Uri.parse('....'));
    //if (response.statusCode == 200) {
      //List jsonResponse = json.decode(response.body);
     // return jsonResponse.map((data) => Doctor.fromJson(data)).toList();
    //} else {
     // throw Exception('Failed to load doctor data');
    //}

    final String response = await rootBundle.loadString('assets/doctor.json');
    List jsonResponse = json.decode(response);
    return jsonResponse.map((data) => Doctor.fromJson(data)).toList();
  }
}
class DoctorSelectionPage extends StatefulWidget {
  @override
  _DoctorSelectionPageState createState() => _DoctorSelectionPageState();
}

class _DoctorSelectionPageState extends State<DoctorSelectionPage> {
  final DoctorService doctorService = DoctorService();
  TextEditingController _searchController = TextEditingController();
  List<Doctor> _filteredDoctors = [];
  List<Doctor> _allDoctors = [];

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  //loadthongtin
  Future<void> _loadDoctors() async {
    List<Doctor> doctors = await doctorService.fetchDoctors();
    setState(() {
      _allDoctors = doctors;
      _filteredDoctors = doctors;
    });
  }

  //timkiem
  void _filterDoctors(String query) {
    List<Doctor> filteredList = _allDoctors.where((doctor) {
      return doctor.name.toLowerCase().contains(query.toLowerCase()) ||
          doctor.specialty.toLowerCase().contains(query.toLowerCase());
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
                      print("Doctor selected: ${doctor.name}");

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => .....()),
                      // );
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // edit
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F2B6C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
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
              backgroundImage: NetworkImage(imageUrl),
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