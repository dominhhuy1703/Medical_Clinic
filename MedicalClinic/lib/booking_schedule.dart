import 'package:flutter/material.dart';
import 'provision.dart';
import 'home_screen.dart';
import 'api_service.dart';

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
  int consultationFee = 0;

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
        final department = departments.firstWhere((dept) => dept['name'] == selectedDepartment);
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

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1F2B6C);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Đặt lịch khám',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildDropdown(
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
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: _buildDropdown(
                        label: 'Bác sĩ',
                        items: isLoadingDoctors
                            ? []
                            : doctors.map((doctor) => '${doctor['user']['first_name']} ${doctor['user']['last_name']}').toList(),
                        value: selectedDoctor,
                        onChanged: (value) {
                          setState(() {
                            selectedDoctor = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Giá khám: $consultationFee VNĐ',
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
      isExpanded: true, // Để dropdown không bị tràn
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
          child: Text(
            item,
            overflow: TextOverflow.ellipsis, // Rút gọn nếu quá dài
          ),
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
}