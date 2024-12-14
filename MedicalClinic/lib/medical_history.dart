import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import thư viện intl
import 'profile.dart';
import 'api_service.dart'; // Import ApiService
import 'package:provider/provider.dart';
import 'token_provider.dart';

class MedicalHistoryPage extends StatefulWidget {
  @override
  _MedicalHistoryPageState createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends State<MedicalHistoryPage> {
  List<Map<String, dynamic>> appointments = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  // Hàm tải dữ liệu từ API
  Future<void> fetchAppointments() async {
    try {
      final data = await ApiService.getAppointmentsByUserId(context);
      setState(() {
        appointments = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  // Hàm định dạng ngày
  String formatDate(String appointmentDate) {
    try {
      DateTime parsedDate = DateTime.parse(appointmentDate);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return 'N/A';
    }
  }

  // Hàm định dạng giờ
  String formatTime(String appointmentDate) {
    try {
      DateTime parsedDate = DateTime.parse(appointmentDate);
      return DateFormat('HH:mm').format(parsedDate);
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Lịch sử khám bệnh',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1F2B6C),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              color: Color(0xFF1F2B6C),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Ngày hẹn',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Giờ hẹn',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Trạng thái',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Hiển thị dữ liệu
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator()) // Hiển thị loading
                  : errorMessage.isNotEmpty
                  ? Center(child: Text(errorMessage)) // Hiển thị lỗi
                  : appointments.isEmpty
                  ? Center(child: Text('Không có lịch sử khám bệnh'))
                  : ListView.separated(
                itemCount: appointments.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1),
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        // Ngày hẹn
                        Expanded(
                          flex: 2,
                          child: Text(
                            formatDate(appointment[
                            "appointment_date"] ??
                                ''),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Giờ hẹn
                        Expanded(
                          flex: 2,
                          child: Text(
                            formatTime(appointment[
                            "appointment_date"] ??
                                ''),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Trạng thái
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.teal[100],
                              borderRadius:
                              BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              appointment["status"] ?? 'N/A',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.teal[900],
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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
