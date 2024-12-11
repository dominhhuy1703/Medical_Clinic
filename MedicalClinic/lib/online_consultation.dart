import 'package:flutter/material.dart';

class OnlineConsultationScreen extends StatefulWidget {
  @override
  _OnlineConsultationScreenState createState() =>
      _OnlineConsultationScreenState();
}

class _OnlineConsultationScreenState extends State<OnlineConsultationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': message});
    });

    Future.delayed(Duration(milliseconds: 500), () {
      final response = _getBotResponse(message);
      setState(() {
        _messages.add({'sender': 'bot', 'text': response});
      });
    });

    _messageController.clear();
  }

  String _getBotResponse(String userMessage) {
    userMessage = removeAccents(userMessage.toLowerCase());

    if (userMessage.contains("chao")) {
      return "Chào bạn! Tôi có thể giúp gì cho bạn hôm nay?";
    } else if (userMessage.contains("gio lam viec")) {
      return "Phòng khám mở cửa từ 8h sáng đến 8h tối, từ thứ 2 đến thứ 7.";
    } else if (userMessage.contains("chi phi")) {
      return "Chi phí khám bệnh tổng quát là 500,000 VNĐ.";
    } else if (userMessage.contains("cam on")) {
      return "Rất vui được hỗ trợ bạn!";
    } else if (userMessage.contains("dau dau")) {
      return "Đau đầu kéo dài có thể nguy hiểm, bạn nên đi khám để được tư vấn cụ thể.";
    } else if (userMessage.contains("tang suc de khang")) {
      return "Ăn nhiều thực phẩm giàu vitamin C như cam, chanh, và tập thể dục đều đặn sẽ giúp tăng sức đề kháng.";
    } else if (userMessage.contains("ngat")) {
      return "Nếu gặp người bị ngất, hãy đặt người đó nằm ngửa, nâng chân cao hơn đầu và gọi cấp cứu nếu cần.";
    } else if (userMessage.contains("bong nuoc soi")) {
      return "Rửa vết bỏng dưới vòi nước mát trong 15-20 phút, sau đó che bằng gạc sạch và đến cơ sở y tế.";
    } else if (userMessage.contains("di vat")) {
      return "Cố gắng ho mạnh để đẩy dị vật ra. Nếu không hiệu quả, áp dụng kỹ thuật Heimlich hoặc gọi cấp cứu.";
    } else if (userMessage.contains("tai nan giao thong")) {
      return "Không di chuyển nạn nhân nếu nghi ngờ chấn thương cột sống. Gọi cấp cứu và giữ nạn nhân tỉnh táo.";
    } else {
      return "Xin lỗi, tôi chưa hiểu câu hỏi của bạn. Bạn có thể đặt câu hỏi cụ thể hơn không?";
    }
  }

  String removeAccents(String str) {
    const Map<String, String> accentsMap = {
      'á': 'a', 'à': 'a', 'ả': 'a', 'ã': 'a', 'ạ': 'a',
      'é': 'e', 'è': 'e', 'ẻ': 'e', 'ẽ': 'e', 'ẹ': 'e',
      'í': 'i', 'ì': 'i', 'ỉ': 'i', 'ĩ': 'i', 'ị': 'i',
      'ó': 'o', 'ò': 'o', 'ỏ': 'o', 'õ': 'o', 'ọ': 'o',
      'ú': 'u', 'ù': 'u', 'ủ': 'u', 'ũ': 'u', 'ụ': 'u',
      'ý': 'y', 'ỳ': 'y', 'ỷ': 'y', 'ỹ': 'y', 'ỵ': 'y',
      'ă': 'a', 'â': 'a', 'ê': 'e', 'ô': 'o', 'ơ': 'o',
      'ư': 'u', 'đ': 'd',
    };

    return str.split('').map((char) {
      return accentsMap[char] ?? char;
    }).join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tư vấn trực tuyến',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF1F2B6C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Color(0xFF1F2B6C) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _sendMessage(_messageController.text),
                  child: Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1F2B6C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
