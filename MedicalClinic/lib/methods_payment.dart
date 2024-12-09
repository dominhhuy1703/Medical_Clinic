import 'package:flutter/material.dart';
import 'provision.dart';
import 'credit_card.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MethodPaymentpage(),
    );
  }
}

class MethodPaymentpage extends StatefulWidget {
  @override
  _MethodPaymentpageState createState() => _MethodPaymentpageState();
}

class _MethodPaymentpageState extends State<MethodPaymentpage> {
  String selectedOption = 'Thẻ tín dụng';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thông tin đặt khám',
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
            // Credit Card Display
            Center(
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.deepPurpleAccent,
                  image: DecorationImage(
                    image: AssetImage('assets/credit_card.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Visa 5153 3963 0491 9976',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreditInfoPage()),
                      );
                    },
                  child: Text(
                    'Change',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Payment Options
            PaymentOption(
              label: 'Thẻ tín dụng',
              selectedOption: selectedOption,
              onSelect: () => setState(() => selectedOption = 'Thẻ tín dụng'),
            ),
            PaymentOption(
              label: 'Thẻ ATM',
              selectedOption: selectedOption,
              onSelect: () => setState(() => selectedOption = 'Thẻ ATM'),
            ),
            PaymentOption(
              label: 'Thêm thẻ khác',
              selectedOption: selectedOption,
              onSelect: () => setState(() => selectedOption = 'Thêm thẻ khác'),
            ),
            Spacer(),

            Center(
            child:ElevatedButton(
              onPressed: () {
                // Handle payment action
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => CreditInfoPage()),
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
                'Thanh toán',
                style: TextStyle(fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
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

// Widget for each payment option
class PaymentOption extends StatelessWidget {
  final String label;
  final String selectedOption;
  final VoidCallback onSelect;

  PaymentOption({
    required this.label,
    required this.selectedOption,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selectedOption == label ? Colors.blue.shade50 : Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
            Icon(
              selectedOption == label ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
