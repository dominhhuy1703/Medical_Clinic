import 'package:flutter/material.dart';
import 'provision.dart';
import 'home_screen.dart';
import 'api_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MaterialApp(home: BookingPage()));
}

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedGender;
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
  final List<String> availableTimes = [
    '9:00',
    '10:00',
    '11:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00'
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserInfo(); // Lấy thông tin người dùng hiện tại
    _fetchDepartments(); // Gọi API lấy danh sách khoa ngay khi khởi tạo
  }

  Future<void> _fetchUserInfo() async {
    try {
      print("Bắt đầu lấy thông tin người dùng...");
      final data = await ApiService.getLoggedInUserInfo(context);
      print("Thông tin người dùng nhận được: $data");

      setState(() {
        userInfo = data;
        nameController.text = '${userInfo?['first_name'] ?? ''} ${userInfo?['last_name'] ?? ''}';
        emailController.text = userInfo?['email'] ?? '';
        phoneController.text = userInfo?['phone'] ?? '';
      });
    } catch (e) {
      print("Lỗi khi lấy thông tin người dùng: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không thể tải thông tin người dùng")),
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
      print("Lỗi khi gọi API: $e");
      setState(() {
        isLoadingDepartments = false;
      });
    }
  }

  Future<void> _fetchDoctors() async {
    if (selectedDepartment != null) {
      try {
        final department = departments.firstWhere(
              (dept) => dept['name'] == selectedDepartment,
        );
        final departmentId = department['id'];

        setState(() {
          isLoadingDoctors = true;
        });

        final doctorData = await ApiService.getDoctorsByDepartment(departmentId, context);

        setState(() {
          doctors = doctorData;
          isLoadingDoctors = false;
        });
      } catch (e) {
        print("Lỗi khi lấy danh sách bác sĩ: $e");
        setState(() {
          isLoadingDoctors = false;
        });
      }
    }
  }

  void _updateConsultationFee(String? doctorName) {
    if (doctorName != null && doctors.isNotEmpty) {
      final selectedDoctorData = doctors.firstWhere(
            (doctor) =>
        '${doctor['user']['first_name']} ${doctor['user']['last_name']}' == doctorName,
        orElse: () => {},
      );

      if (selectedDoctorData.isNotEmpty) {
        setState(() {
          consultationFee = selectedDoctorData['consultation_fee'] ?? 0;
        });
      } else {
        setState(() {
          consultationFee = 0; // Nếu không tìm thấy, set giá khám là 0
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ) ?? DateTime.now();
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
        );

        if (pickedTime != null) {
          setState(() {
            selectedTime = pickedTime;
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
          controller: TextEditingController(text: selectedTime?.format(context)),
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    print("Bắt đầu đặt lịch...");
    if (_formKey.currentState!.validate()) {
      // Kiểm tra các trường bắt buộc đã được chọn
      if (selectedDate == null || selectedTime == null || selectedDoctor == null) {
        print("Thiếu thông tin: selectedDate=$selectedDate, selectedTime=$selectedTime, selectedDoctor=$selectedDoctor");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vui lòng chọn ngày, giờ và bác sĩ')));
        return;
      }

      // Chuyển đổi giờ từ TimeOfDay sang DateTime
      final DateTime appointmentDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      print("Thời gian đặt lịch: $appointmentDateTime");

      // Giả sử bạn đã có doctorId (có thể từ danh sách bác sĩ)
      final doctor = doctors.firstWhere(
            (doctor) => '${doctor['user']['first_name']} ${doctor['user']['last_name']}' == selectedDoctor,
        orElse: () => {'id': -1},
      );
      final doctorId = doctor['id'];

      if (doctorId == -1) {
        print("Không tìm thấy bác sĩ: selectedDoctor=$selectedDoctor");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Không tìm thấy bác sĩ')));
        return;
      }

      print("Doctor ID: $doctorId");

      // Gọi phương thức tạo cuộc hẹn từ ApiService
      try {
        print("Gửi yêu cầu tạo lịch hẹn...");
        final response = await ApiService.createAppointment(
          doctorId: doctorId,
          appointmentDate: appointmentDateTime,
          status: 'Scheduled', // Trạng thái cuộc hẹn
          context: context,
        );

        print("Phản hồi từ server: $response");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đặt lịch thành công!')));
      } catch (e) {
        // Log lỗi chi tiết
        print("Lỗi khi đặt lịch: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đặt lịch thất bại: $e')));
      }
    } else {
      print("Form không hợp lệ");
    }
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
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
                  hint: 'Nhập email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: phoneController,
                  label: 'Số điện thoại',
                  hint: 'Nhập số điện thoại',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                _buildDropdown(
                  label: 'Giới tính',
                  items: ['Nam', 'Nữ'],
                  value: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                // Di chuyển phần chọn ngày và giờ lên trên
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: _buildDateField(),
                ),
                const SizedBox(height: 12),
                _buildTimePicker(),
                const SizedBox(height: 12),
                _buildDropdown(
                  label: 'Khoa',
                  items: isLoadingDepartments
                      ? []
                      : departments.map((department) => department['name'] as String).toList(),
                  value: selectedDepartment,
                  onChanged: (value) {
                    setState(() {
                      selectedDepartment = value;
                    });
                    _fetchDoctors(); // Gọi API lấy danh sách bác sĩ khi chọn khoa
                  },
                ),
                const SizedBox(height: 12),
                _buildDropdown(
                  label: 'Bác sĩ',
                  items: isLoadingDoctors
                      ? []
                      : doctors
                      .map((doctor) => '${doctor['user']['first_name']} ${doctor['user']['last_name']}')
                      .toList(),
                  value: selectedDoctor,
                  onChanged: (value) {
                    setState(() {
                      selectedDoctor = value;
                    });
                    _updateConsultationFee(value);
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  'Giá khám: ${consultationFee != null ? '$consultationFee VND' : 'Chưa có thông tin'}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 36),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      backgroundColor: primaryColor,
                    ),
                    onPressed: _onSubmit, // Gọi phương thức _onSubmit khi nhấn nút
                    child: const Text(
                      'Đặt lịch',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    String? value,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDateField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        selectedDate == null
            ? 'Chưa chọn ngày'
            : DateFormat('dd/MM/yyyy').format(selectedDate!),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
