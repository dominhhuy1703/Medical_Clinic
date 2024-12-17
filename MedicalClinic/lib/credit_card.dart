import 'package:flutter/material.dart';
import 'provision.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import 'token_provider.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<TokenProvider>(context).token;

    return MaterialApp(
      home: CreditInfoPage(),
    );
  }
}

class CreditInfoPage extends StatelessWidget {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController beneficiaryController = TextEditingController();
  final TextEditingController amountController =
  TextEditingController(text: '450.000'); // Số tiền mặc định
  final TextEditingController contentController = TextEditingController();
  final TextEditingController emailController = TextEditingController(); // Mã xác thực

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thẻ nội địa và tài khoản ngân hàng',
          style: TextStyle(color: Color(0xFF1F2B6C), fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1F2B6C)),
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
            // Số thẻ
            TextField(
              controller: cardNumberController,
              decoration: InputDecoration(
                labelText: 'Số thẻ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Tên người thụ hưởng
            TextField(
              controller: beneficiaryController,
              decoration: InputDecoration(
                labelText: 'Tên người thụ hưởng',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 2),
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              ),
            ),
            SizedBox(height: 16),

            // Số tiền
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Số tiền',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 2),
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                suffixIcon: Icon(Icons.attach_money),
              ),
            ),
            SizedBox(height: 16),

            // Ngày phát hành
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Ngày phát hành MM/DD',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 2),
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              ),
            ),
            SizedBox(height: 16),

            // Mã xác thực
            TextField(
              controller: emailController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Mã xác thực',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 2),
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              ),
            ),
            Spacer(),

            // Nút Thanh toán
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (cardNumberController.text.isEmpty ||
                      beneficiaryController.text.isEmpty ||
                      amountController.text.isEmpty ||
                      contentController.text.isEmpty ||
                      emailController.text.isEmpty) {
                    // Hiển thị thông báo lỗi
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Vui lòng nhập đầy đủ thông tin'),
                      ),
                    );
                  } else {
                    // Hiển thị thông báo thành công
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Thanh toán thành công")),
                    );

                    // Chuyển về trang HomeScreen sau 1 giây
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F2B6C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: Text(
                  'Thanh toán',
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

// Màn hình HomeScreen