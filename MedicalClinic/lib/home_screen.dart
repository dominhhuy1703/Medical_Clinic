import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'token_provider.dart';
import 'booking_schedule.dart';
import 'medical_history.dart';
import 'personal_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TokenProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MedicalHistoryPage(),
    BookingPage(),
    PersonalScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF1F2B6C);

    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Lịch sử khám'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Đặt lịch'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF1F2B6C);

    //
    List<Map<String, String>> blogs = [
      {'title': '5 mẹo chăm sóc sức khỏe', 'content': 'Khám phá cách giữ sức khỏe hàng ngày.'},
      {'title': 'Lợi ích của việc khám sức khỏe định kỳ', 'content': 'Tại sao nên khám định kỳ?'},
      {'title': 'Dinh dưỡng hợp lý', 'content': 'Thực đơn lành mạnh cho bạn và gia đình.'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '👋 Xin chào',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Tin tức ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(blogs[index]['title'] ?? ''),
                    subtitle: Text(blogs[index]['content'] ?? ''),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
