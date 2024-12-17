import 'package:flutter/material.dart';
import 'provision.dart';
import 'home_screen.dart';
import 'api_service.dart';
import 'package:intl/intl.dart';
import 'credit_card.dart';
import 'package:url_launcher/url_launcher.dart';




class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();

  bool _isChecked = false;
  String? selectedDepartment;
  String? selectedDoctor;
  int? consultationFee;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Map<String, dynamic>? userInfo;
  List<Map<String, dynamic>> departments = [];
  List<Map<String, dynamic>> doctors = [];
  bool isLoadingDepartments = true;
  bool isLoadingDoctors = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
    _fetchDepartments();
  }
  //URL Vnpay



  Future<void> _fetchUserInfo() async {
    try {
      final data = await ApiService.getLoggedInUserInfo(context);
      setState(() {
        userInfo = data;
        nameController.text = '${data['first_name']} ${data['last_name']}';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone'] ?? '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể tải thông tin người dùng')),
      );
    }
  }

  Future<void> _fetchDepartments() async {
    try {
      final data = await ApiService.getDepartments(context);
      setState(() {
        departments = data;
        isLoadingDepartments = false;
      });
    } catch (e) {
      setState(() => isLoadingDepartments = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể tải danh sách khoa')),
      );
    }
  }

  Future<void> _fetchDoctors() async {
    if (selectedDepartment == null) return;

    try {
      final department = departments.firstWhere(
            (dept) => dept['name'] == selectedDepartment,
        orElse: () => {},
      );
      final departmentId = department['id'];

      setState(() => isLoadingDoctors = true);

      final data = await ApiService.getDoctorsByDepartment(departmentId, context);
      setState(() {
        doctors = data;
        isLoadingDoctors = false;
      });
    } catch (e) {
      setState(() => isLoadingDoctors = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể tải danh sách bác sĩ')),
      );
    }
  }

  void _updateConsultationFee(String? doctorName) {
    if (doctorName == null) return;

    final doctor = doctors.firstWhere(
          (doc) =>
      '${doc['user']['first_name']} ${doc['user']['last_name']}' == doctorName,
      orElse: () => {},
    );

    setState(() {
      consultationFee = doctor['consultation_fee'] ?? 0;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) setState(() => selectedTime = picked);
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedDate == null || selectedTime == null || selectedDoctor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn ngày, giờ và bác sĩ')),
      );
      return;
    }

    final doctor = doctors.firstWhere(
          (doc) => '${doc['user']['first_name']} ${doc['user']['last_name']}' == selectedDoctor,
      orElse: () => {'id': -1},
    );

    if (doctor['id'] == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bác sĩ không hợp lệ')),
      );
      return;
    }

    final appointmentDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    try {
      final response = await ApiService.createAppointment(
        doctorId: doctor['id'],
        appointmentDate: appointmentDateTime,
        status: 'Scheduled',
        context: context,
      );

      if (response != null) {
        // Nếu tạo lịch hẹn thành công
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lịch hẹn đã được tạo thành công')),
        );
      } else {
        // Nếu không có phản hồi hoặc lỗi trong quá trình tạo lịch hẹn
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể tạo lịch hẹn')),
        );
      }
    } catch (e) {
      // Xử lý lỗi khi API gọi gặp sự cố
      print('create appointment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('DONE')),
      );
    } finally {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreditInfoPage()),
      );
    }
  }


  Future<void> _launchPaymentUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      print(': $url');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('')),
      );
    }
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
          helpText: 'Chọn giờ',
        );

        if (pickedTime != null) {
          final fixedTime = TimeOfDay(hour: pickedTime.hour, minute: 0);
          setState(() {
            selectedTime = fixedTime;
          });
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Giờ',
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: (value) {
            if (selectedTime == null) {
              return 'Hãy chọn giờ';
            }
            return null;
          },
          controller: TextEditingController(
            text: selectedTime != null
                ? '${selectedTime!.hour.toString().padLeft(2, '0')}:00'
                : '',
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1F2B6C);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Đặt lịch khám',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hãy điền các thông tin ',
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: nameController,
                  label: 'Tên',
                  hint: 'Nhập tên của bạn',
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: emailController,
                  label: 'Email',
                  hint: 'Nhập email của bạn',
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: phoneController,
                  label: 'Số điện thoại',
                  hint: 'Nhập số điện thoại',
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedDepartment,
                  items: departments.map<DropdownMenuItem<String>>((dept) {
                    return DropdownMenuItem<String>(
                      value: dept['name'],
                      child: Text(dept['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDepartment = value;
                      selectedDoctor = null;
                      _fetchDoctors();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Chọn khoa',
                    filled: true,
                    fillColor: const Color(0xFFF3F4F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                isLoadingDoctors
                    ? CircularProgressIndicator()
                    : DropdownButtonFormField<String>(
                  value: selectedDoctor,
                  items: doctors.map<DropdownMenuItem<String>>((doctor) {
                    return DropdownMenuItem<String>(
                      value: '${doctor['user']['first_name']} ${doctor['user']['last_name']}',
                      child: Text(
                          '${doctor['user']['first_name']} ${doctor['user']['last_name']}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDoctor = value;
                    });
                    _updateConsultationFee(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Chọn bác sĩ',
                    filled: true,
                    fillColor: const Color(0xFFF3F4F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Chọn ngày'),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      selectedDate == null
                          ? 'Ngày chưa chọn'
                          : DateFormat('dd/MM/yyyy').format(selectedDate!),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTimePicker(),
                const SizedBox(height: 12),
                Text(
                  'Phí khám: ${consultationFee != null ? NumberFormat.currency(
                      symbol: '₫').format(consultationFee) : 'Chưa có'}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Đồng ý với yêu cầu điều khoản',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ProvisionPage()),
                        );
                      },
                      child: const Text(
                        'Chi tiết',
                        style: TextStyle(
                          color: Color(0xFF1F2B6C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: ElevatedButton(
                    onPressed: _isChecked ? _onSubmit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isChecked ? primaryColor : Colors.grey,
                    ),
                    child: const Text(
                      'Đặt lịch',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập $label';
        }
        return null;
      },
    );
  }
}
