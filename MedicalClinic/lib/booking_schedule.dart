import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'provision.dart';
import 'methods_payment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SchedulePage(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController notesController = TextEditingController();

  // pick dtae
  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // pick time
  Future<void> pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  void submitBooking() {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng điền đầy đủ thông tin")),
      );
      return;
    }

    final dateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đặt lịch thành công vào $dateTime")),
    );

    clearForm();
  }

  void clearForm() {
    setState(() {
      selectedDate = null;
      selectedTime = null;
      notesController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProvisionPage()),
            );
          },
        ),
        title: Text(
          'Đặt lịch khám',
          style: TextStyle(color: Color(0xFF1F2B6C), fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chọn ngày
            TextButton(
              onPressed: pickDate,
              child: Text(
                selectedDate == null
                    ? "Chọn ngày"
                    : "Ngày: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}",
                style: TextStyle(fontSize: 16, color: Color(0xFF1F2B6C)),
              ),
            ),
            SizedBox(height: 16),
            // Chọn giờ
            TextButton(
              onPressed: pickTime,
              child: Text(
                selectedTime == null
                    ? "Chọn giờ"
                    : "Giờ: ${selectedTime!.format(context)}",
                style: TextStyle(fontSize: 16, color: Color(0xFF1F2B6C)),
              ),
            ),
            SizedBox(height: 16),
            // Ghi chú
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: "Ghi chú (tùy chọn)",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
              maxLines: 3,
            ),
            Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  submitBooking();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MethodPaymentpage()),
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
                  'Đặt lịch',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
