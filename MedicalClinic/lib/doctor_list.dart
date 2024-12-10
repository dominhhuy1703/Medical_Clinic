import 'package:flutter/material.dart';
import 'doctor_detail.dart';

class DoctorListPage extends StatefulWidget {
  final String specialty;
  DoctorListPage({required this.specialty});

  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Bellamy N',
      'specialty': 'Virologist',
      'rating': '4.5',
      'reviews': '135 reviews',
      'image': 'assets/doctor1.png',
    },
    {
      'name': 'Dr. Mensah T',
      'specialty': 'Oncologists',
      'rating': '4.3',
      'reviews': '130 reviews',
      'image': 'assets/doctor2.png',
    },
    {
      'name': 'Dr. Klimisch J',
      'specialty': 'Surgeon',
      'rating': '4.5',
      'reviews': '125 reviews',
      'image': 'assets/doctor3.png',
    },
    {
      'name': 'Dr. Martinez K',
      'specialty': 'Pediatrician',
      'rating': '4.3',
      'reviews': '110 reviews',
      'image': 'assets/doctor4.png',
    },
  ];

  List<Map<String, String>> _filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    _filteredDoctors = doctors;
  }

  void _filterDoctors() {
    setState(() {
      _filteredDoctors = doctors
          .where((doctor) =>
      doctor['name']!.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          doctor['specialty']!.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _goToDoctorDetail(Map<String, String> doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorDetailPage(doctor: doctor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.specialty} Bác Sĩ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1F2B6C),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _filterDoctors();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm bác sĩ',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => _filterDoctors(),
            ),
            SizedBox(height: 16),
            Flexible(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: _filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = _filteredDoctors[index];
                  return GestureDetector(
                    onTap: () => _goToDoctorDetail(doctor),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              doctor['image']!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            doctor['name']!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            doctor['specialty']!,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              SizedBox(width: 4),
                              Text(
                                '${doctor['rating']} (${doctor['reviews']})',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
