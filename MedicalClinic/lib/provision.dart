import 'package:flutter/material.dart';
import 'methods_payment.dart';
void main() {
  runApp(MyApp());
}

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
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<ProvisionPage> {
  bool _isAccepted = false;

  final List<TermsContent> terms = [
    TermsContent(
      title: '1. Phạm vi sử dụng',
      content:
      '- Các điều khoản và điều kiện này áp dụng cho việc sử dụng dịch vụ của công ty chúng tôi...\n'
          '- Bằng việc sử dụng dịch vụ đặt lịch và thanh toán, bệnh nhân đồng ý tuân thủ các điều khoản và điều kiện được quy định dưới đây',
    ),
    TermsContent(
      title: '2. Nghĩa vụ và trách nhiệm',
      content:
      '- Bệnh nhân phải cung cấp đầy đủ và chính xác thông tin cá nhân khi đặt lịch khám. Hệ thống sẽ không chịu trách nhiệm đối với mọi sai sót hoặc nhầm lẫn trong thông tin mà bệnh nhân cung cấp.\n'
          '- Sau khi hoàn thành đặt lịch, bệnh nhân sẽ nhận được thông báo xác nhận qua email hoặc tin nhắn.',
    ),
    TermsContent(
      title: '3. Thanh toán',
      content:
      '- Thanh toán phải được thực hiện trực tuyến qua các phương thức thanh toán được chấp nhận trên hệ thống.\n'
          '- Bệnh nhân cần thanh toán toàn bộ chi phí khám trước khi tới khám. Chúng tôi không chấp nhận thanh toán trực tiếp tại cơ sở khám chữa bệnh.',
    ),
  TermsContent(
    title: '4.Chính sách hủy lịch',
    content:
      '- Bệnh nhân có quyền hủy lịch khám trước thời gian đã đặt với các điều kiện sau:\n'
      '   Hủy trước 24 giờ: hoàn trả 100% chi phí.\n'
      '   Hủy trong vòng 24 giờ trước giờ khám: không hoàn trả chi phí.\n'
      '   Bệnh nhân có thể yêu cầu thay đổi lịch khám nhưng không quá 2 lần và phải yêu cầu trước ít nhất 24 giờ.'
  ),
      TermsContent(
      title: '5. Quyền và trách nhiệm của bệnh nhân',
      content:
        '- Bệnh nhân có trách nhiệm cung cấp thông tin chính xác, thanh toán đầy đủ và đúng hạn.\n'
        '- Bệnh nhân phải đến khám đúng giờ theo lịch hẹn. Nếu bệnh nhân đến muộn quá 15 phút so với giờ hẹn, lịch hẹn có thể bị hủy mà không được hoàn tiền.',
      ),
  TermsContent(
      title: '6. Bảo mật thông tin',
      content:
        '- Thông tin cá nhân của bệnh nhân sẽ được bảo mật và chỉ sử dụng cho mục đích khám chữa bệnh. Chúng tôi cam kết không chia sẻ thông tin này với bên thứ ba mà không có sự đồng ý của bệnh nhân.'
  ),
    TermsContent(
      content: 'Mọi tranh chấp phát sinh từ việc sử dụng dịch vụ sẽ được giải quyết theo quy định của pháp luật Việt Nam. Nếu không thể giải quyết thông qua thỏa thuận, tranh chấp sẽ được đưa ra giải quyết tại tòa án có thẩm quyền.', title: ''
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,
        title: Text('Điều khoản và điều kiện',
        style: TextStyle(
          color: Color(0xFF1F2B6C),
          //
        ),
      ),
      centerTitle: true,
      elevation: 0,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: terms.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          terms[index].title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          terms[index].content,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      _isAccepted = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    'Tôi đã đọc và đồng ý với các điều khoản trên',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isAccepted
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MethodPaymentpage()),
                );

              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F2B6C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
              child: Text(
                'Thanh toán',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
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
