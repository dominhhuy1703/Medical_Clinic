import 'package:flutter/material.dart';
import 'provision.dart'; // Added missing semicolon

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreditInfoPage(),
    );
  }
}

class CreditInfoPage extends StatelessWidget {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController beneficiaryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thông tin thanh toán',
          style: TextStyle(color: Color(0xFF1F2B6C), fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProvisionPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Number
            TextField(
              controller: cardNumberController,
              decoration: InputDecoration(
                labelText: 'Số thẻ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            TextField(
              controller: beneficiaryController,
              decoration: InputDecoration(
                labelText: 'Tên người thụ hưởng',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Số tiền',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                suffixIcon: Icon(Icons.attach_money), // Added suffixIcon here
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Nội dung',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              ),
            ),
            Spacer(),

            Center( // Center the button
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Đặt lịch khám thành công")),
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
                  'Đặt lịch khám',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
