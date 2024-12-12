import 'package:flutter/material.dart';
import 'provision.dart';
import 'home_screen.dart';
import 'api_service.dart';
import 'package:intl/intl.dart';
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
  int ?consultationFee ;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  List<Map<String, dynamic>> departments = [];
  List<Map<String, dynamic>> doctors = [];
  bool isLoadingDepartments = true;
  bool isLoadingDoctors = false;


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final List<String> availableTimes = [];

  @override
  void initState() {
    super.initState();
    _fetchDepartments();
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
        final department = departments.firstWhere((dept) =>
        dept['name'] == selectedDepartment);
        final departmentId = department['id'];

        setState(() {
          isLoadingDoctors = true;
        });

        final doctorData = await ApiService.getDoctorsByDepartment(
            departmentId, context);

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
        '${doctor['user']['first_name']} ${doctor['user']['last_name']}' ==
            doctorName,
        orElse: () => {},
      );

      if (selectedDoctorData.isNotEmpty) {
        setState(() {
          consultationFee = selectedDoctorData['consultation_fee'] ?? 0;
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
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Giờ hẹn',
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      value: selectedTime != null
          ? availableTimes.firstWhere(
              (time) => time == selectedTime!.format(context))
          : null,
      items: availableTimes.map((String time) {
        return DropdownMenuItem<String>(
          value: time,
          child: Text(time),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedTime = TimeOfDay(
              hour: int.parse(value!.split(':')[0]),
              minute: int.parse(value.split(':')[1]));
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng chọn giờ';
        }
        return null;
      },
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
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: _buildDateField(),
                ),
                const SizedBox(height: 12),
                _buildTimePicker(),
                const SizedBox(height: 12),
                Text(
                  'Giá khám: ',
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProvisionPage()),
                        );
                      }
                    },
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
    void Function(String?)? onChanged,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng chọn $label';
        }
        return null;
      },
    );
  }

  Widget _buildDateField() {
    final formattedDate = selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
        : 'Chưa chọn ngày';
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Ngày hẹn',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        formattedDate,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
