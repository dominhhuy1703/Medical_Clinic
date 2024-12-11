import 'package:flutter/material.dart';
import 'doctor_list.dart';

class SpecialityScreen extends StatefulWidget {
  @override
  _SpecialityScreenState createState() => _SpecialityScreenState();
}

class _SpecialityScreenState extends State<SpecialityScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<String> _specialities = [
    'Nội khoa', 'Ngoại khoa', 'Răng hàm mặt', 'Khoa mắt', 'Tai mũi họng', 'Da liễu',
    'Nhi khoa', 'Khoa thần kinh', 'Tim mạch', 'Khoa tiết niệu', 'Khoa xương khớp', 'Khoa sản'
  ];

  List<String> _filteredSpecialities = [];

  @override
  void initState() {
    super.initState();
    _filteredSpecialities = _specialities;
  }

  void _filterSpecialities() {
    setState(() {
      _filteredSpecialities = _specialities
          .where((speciality) => speciality.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  Widget _buildSpecialityItem(String speciality) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorListPage(specialty: speciality),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_hospital,
              size: 50,
              color: Colors.blueAccent,
            ),
            SizedBox(height: 8),
            Text(
              speciality,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chuyên Khoa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1F2B6C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm chuyên khoa',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => _filterSpecialities(),
            ),
            SizedBox(height: 16),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),//
                  itemCount: _filteredSpecialities.length,
                itemBuilder: (context, index) {
                  return _buildSpecialityItem(_filteredSpecialities[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
