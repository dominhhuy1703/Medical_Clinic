import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': '🎉 HOÀN TIỀN 5% khi đặt lịch tiêm HPV qua Meddical 🎉',
      'content': '🎉 Đừng quên chăm sóc sức khỏe với ưu đãi đặc biệt!',
      'time': '1 tuần trước',
    },
    {
      'title': '🔥 TẶNG VOUCHER 50% Xét Nghiệm Ung Thư Cổ Tử Cung 🔥',
      'content': '🔥 Nhận voucher ngay hôm nay!',
      'time': '2 tuần trước',
    },
    {
      'title': '🔥 Giảm giá 30% điều trị da liễu 🔥',
      'content': '🔥 Nhanh tay đặt lịch khám!',
      'time': '15/09/2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Danh sách thông báo',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1F2B6C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification['title']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    notification['content']!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    notification['time']!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
