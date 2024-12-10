import 'package:flutter/material.dart';
import 'detail_service.dart';

class ServiceClinicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Service> services = [
      Service(
        title: 'Khám bệnh tổng quát',
        description: 'Khám tổng quát giúp phát hiện sớm các vấn đề sức khỏe.',
        detailedDescription:
        'Dịch vụ khám bệnh tổng quát bao gồm kiểm tra sức khỏe tổng thể, thực hiện các xét nghiệm cơ bản, và tư vấn từ bác sĩ chuyên môn để đảm bảo sức khỏe tốt nhất cho bạn.',
        imageUrl: 'assets/service_1.png',
        price: 500000,
        id: 1,
      ),
      Service(
        title: 'Xét nghiệm máu',
        description: 'Đảm bảo sức khỏe của bạn qua các xét nghiệm máu chính xác.',
        detailedDescription:
        'Dịch vụ xét nghiệm máu bao gồm phân tích chỉ số sinh hóa, công thức máu, và các yếu tố liên quan khác để phát hiện các vấn đề sức khỏe tiềm ẩn.',
        imageUrl: 'assets/service_2.png',
        price: 300000,
        id: 2,
      ),
      Service(
        title: 'Tư vấn trực tuyến',
        description: 'Nhận tư vấn từ các bác sĩ qua các buổi khám trực tuyến.',
        detailedDescription:
        'Dịch vụ tư vấn trực tuyến giúp bạn nhận được sự hỗ trợ y tế từ xa mà không cần đến trực tiếp bệnh viện. Thời gian linh hoạt, phù hợp với lịch trình bận rộn.',
        imageUrl: 'assets/service_3.png',
        price: 200000,
        id: 3,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dịch vụ của chúng tôi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF1F2B6C),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Khám phá các dịch vụ của chúng tôi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return _buildServiceCard(service, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(Service service, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              service.imageUrl,
              height: 200,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              service.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2B6C),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              service.description,
              style: TextStyle(fontSize: 14, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailServiceScreen(service: service),
                  ),
                );
              },
              child: Text('Xem thêm →'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F2B6C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Service {
  final String title;
  final String description;
  final String detailedDescription;
  final String imageUrl;
  final int price;
  final int id;

  Service({
    required this.title,
    required this.description,
    required this.detailedDescription,
    required this.imageUrl,
    required this.price,
    required this.id,
  });
}
