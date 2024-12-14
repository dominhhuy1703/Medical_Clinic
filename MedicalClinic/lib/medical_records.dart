import 'package:flutter/material.dart';
import 'profile.dart';
import 'medical_records_detail.dart';
import 'api_service.dart';

class MedicalRecordsPage extends StatelessWidget {
  static const Color primaryColor = Color(0xFF1F2B6C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Hồ Sơ Bệnh Án",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ApiService.getMedicalRecordsByUserId(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final records = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: records.map((record) {
                  return _buildMedicalRecordCard(
                    context,
                    recordId: record['id'] ?? 0,
                    diagnosis: record['diagnosis'] ?? "Không có chẩn đoán",
                    treatmentPlan: record['treatment'] ?? "Không có kế hoạch điều trị",
                    medication: record['prescription'] ?? "Không có đơn thuốc",
                    startDate: record['start_date'] ?? "N/A",
                    endDate: record['end_date'] ?? "N/A",
                    notes: record['notes'] ?? "Không có ghi chú",
                    doctor: record['doctor']?['user']?['first_name'] != null
                        ? "Bác sĩ ${record['doctor']['user']['first_name']} ${record['doctor']['user']['last_name']}"
                        : "Không có thông tin bác sĩ",
                  );
                }).toList(),
              ),
            );
          } else {
            return const Center(child: Text("Không có hồ sơ bệnh án nào."));
          }
        },
      ),
    );
  }

  Widget _buildMedicalRecordCard(
      BuildContext context, {
        required int recordId,
        required String diagnosis,
        required String treatmentPlan,
        required String medication,
        required String startDate,
        required String endDate,
        required String notes,
        required String doctor,
      }) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hồ sơ bệnh án #$recordId",
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2B6C),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildDetailRow("Chẩn đoán", diagnosis),
            _buildDetailRow("Ngày bắt đầu", startDate),
            _buildDetailRow("Ngày kết thúc", endDate),
            _buildDetailRow("Bác sĩ", doctor),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        recordId: recordId,
                        diagnosis: diagnosis,
                        treatmentPlan: treatmentPlan,
                        medication: medication,
                        startDate: startDate,
                        endDate: endDate,
                        notes: notes,
                        doctor: doctor,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Xem chi tiết',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Color(0xFF1F2B6C),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
