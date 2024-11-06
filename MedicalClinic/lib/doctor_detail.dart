import 'package:flutter/material.dart';
import 'dart:convert'; // for json.decode
import 'package:flutter/services.dart'; // for rootBundle
import 'doctor_selection.dart';

class DoctorDetailPage extends StatefulWidget {
  final Doctor doctor;

  DoctorDetailPage({required this.doctor});

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  late List<Doctor> _allDoctors;
  late List<Doctor> _filteredDoctors;

  Future<void> _loadDoctors() async {
    final String response = await rootBundle.loadString('assets/fakedata.json');
    final data = json.decode(response);
    List<Doctor> doctors = (data['doctor_detail'] as List)
        .map((doctorData) => Doctor.fromJson(doctorData))
        .toList();

    setState(() {
      _allDoctors = doctors;
      _filteredDoctors = doctors;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;

    return Scaffold(
      appBar: AppBar(title: Text(doctor.name ?? 'No Name')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(doctor.imageUrl ?? 'assets/default_image.png'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name ?? 'No Name',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Chuyên khoa: ${doctor.specialty ?? 'Unknown'}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        SizedBox(width: 4),
                        Text(
                          "${doctor.rating ?? 'N/A'} (${doctor.reviews ?? '0'} đánh giá)",
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // Bio and Education
            Text("Thông tin bác sĩ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(doctor.bio ?? 'No bio available', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Trình độ học vấn: ${doctor.education ?? 'Not available'}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),

            // Experience
            Text("Kinh nghiệm", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(doctor.experience ?? 'No experience listed', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),

            // Languages
            Text("Ngôn ngữ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(doctor.languages?.join(', ') ?? 'No languages available', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),

            // Treatment Areas
            Text("Lĩnh vực điều trị", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...doctor.treatmentAreas?.map<Widget>((area) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(child: Text(area, style: TextStyle(fontSize: 16))),
                  ],
                ),
              );
            }).toList() ?? [],
            SizedBox(height: 16),

            // Availability
            Text("Lịch khám", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...doctor.availability?.map<Widget>((availability) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      availability['day']?.toString() ?? 'No day available',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      availability['time']?.toString() ?? 'No time available',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }).toList() ?? [],
            SizedBox(height: 16),

            // Contact Info
            Text("Thông tin liên hệ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  doctor.contactInfo?['phone'] ?? 'No phone available',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.email, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  doctor.contactInfo?['email'] ?? 'No email available',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Positioned button at the bottom center
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Edit action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1F2B6C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
