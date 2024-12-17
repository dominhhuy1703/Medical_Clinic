import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProvisionPage(),
    );
  }
}

class ProvisionPage extends StatefulWidget {
  @override
  _ProvisionPageState createState() => _ProvisionPageState();
}

class _ProvisionPageState extends State<ProvisionPage> {
  final List<TermsContent> terms = [
    TermsContent(
      title: '1. Phạm vi sử dụng',
      content: '- Các điều khoản và điều kiện này áp dụng cho việc sử dụng dịch vụ đặt lịch khám...',
    ),
    TermsContent(
      title: '2. Nghĩa vụ và trách nhiệm',
      content: '- Bệnh nhân phải cung cấp đầy đủ thông tin cá nhân chính xác.',
    ),
    TermsContent(
      title: '3. Thanh toán',
      content: '- Thanh toán được thực hiện trực tuyến qua các phương thức có sẵn.',
    ),
    TermsContent(
      title: '4. Chính sách hủy lịch',
      content: '- Hủy trước 24 giờ: hoàn 100%. Hủy trong 24 giờ: không hoàn phí.',
    ),
  ];

  final Color primaryColor = Color(0xFF1F2B6C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Điều khoản và điều kiện',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị danh sách điều khoản
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: terms.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        terms[index].title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        terms[index].content,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TermsContent {
  final String title;
  final String content;

  TermsContent({required this.title, required this.content});
}
