import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final int recordId;
  final String diagnosis;
  final String treatmentPlan;
  final String medication;
  final String startDate;
  final String endDate;
  final String notes;
  final String doctor;

  const DetailPage({
    required this.recordId,
    required this.diagnosis,
    required this.treatmentPlan,
    required this.medication,
    required this.startDate,
    required this.endDate,
    required this.notes,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Chi Tiết Hồ Sơ"),
        backgroundColor: Color(0xFF1F2B6C),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
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
                _buildDetailRow("Phác đồ điều trị", treatmentPlan),
                _buildDetailRow("Đơn thuốc", medication),
                _buildDetailRow("Ngày bắt đầu", startDate),
                _buildDetailRow("Ngày kết thúc", endDate),
                _buildDetailRow("Ghi chú", notes),
                _buildDetailRow("Bác sĩ", doctor),
              ],
            ),
          ),
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
