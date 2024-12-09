import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MedicalRecordsPage(),
  ));
}

class MedicalRecordsPage extends StatelessWidget {
  static const Color primaryColor = Color(0xFF1F2B6C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hồ Sơ Bệnh Án",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        scrollDirection: Axis.horizontal, // cuộn ngang nếu cần
        child: DataTable(
          headingRowColor: MaterialStateProperty.resolveWith(
                (states) => primaryColor,
          ),
          columns: const [
            DataColumn(
              label: Text(
                'Mã Hồ Sơ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Bệnh (Chẩn đoán)',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Ngày Hẹn',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Bác Sĩ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Hành Động',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(Text('')),
              const DataCell(Text('')),
              const DataCell(Text('')),
              const DataCell(Text('')),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          recordId: 6,
                          diagnosis: "",
                          treatmentPlan: "",
                          medication: "",
                          startDate: "",
                          endDate: "",
                          notes: "",
                          doctor: "",
                        ),
                      ),
                    );
                  },
                  child: const Text('Xem chi tiết'),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

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
      appBar: AppBar(
        title: const Text("Chi Tiết Hồ Sơ"),
        backgroundColor: Color(0xFF1F2B6C)
        ,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hồ sơ bệnh án #$recordId",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2B6C)
                    ,
                  ),
                ),
                const SizedBox(height: 16.0),
                _buildRow("Chẩn đoán", diagnosis),
                _buildRow("Phác đồ điều trị", treatmentPlan),
                _buildRow("Đơn thuốc", medication),
                _buildRow("Ngày bắt đầu", startDate),
                _buildRow("Ngày kết thúc", endDate),
                _buildRow("Ghi chú", notes),
                _buildRow("Bác sĩ", doctor),
                const SizedBox(height: 16.0),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
