import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'appointment_overall.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ServicePage(),
    );
  }
}

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  late Future<List<Service>> _services;
  List<Service> _allServices = [];
  List<Service> _filteredServices = [];
  final TextEditingController _searchController = TextEditingController();
  Service? _selectedService;  // Store selected service

  @override
  void initState() {
    super.initState();
    _services = loadServices();
  }

  // Load data
  Future<List<Service>> loadServices() async {
    final String response = await rootBundle.loadString('assets/fakedata.json');
    final data = json.decode(response);
    final List<Service> services = (data['services'] as List)
        .map((serviceData) => Service.fromJson(serviceData))
        .toList();

    setState(() {
      _allServices = services;
      _filteredServices = services;
    });

    return services;
  }

  // timkiem service
  void _filterServices(String query) {
    List<Service> filteredList = _allServices.where((service) {
      return service.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredServices = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppointmentPage()),
            );
          },
        ),
        title: Text(
          'Chọn dịch vụ',
          style: TextStyle(
            color: Color(0xFF1F2B6C),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterServices,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm dịch vụ',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Service>>(
                future: _services,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No services available'));
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = _filteredServices[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedService = service;
                          });
                        },
                        child: ServiceCard(
                          name: service.name,
                          imageUrl: service.imageUrl,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedService == null
                  ? null
                  : () {

                if (_selectedService != null) {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectTimePage(service: _selectedService!),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F2B6C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
              child: Text(
                'Chọn thời gian',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  ServiceCard({
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Service {
  final String name;
  final String imageUrl;

  Service({required this.name, required this.imageUrl});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}

class SelectTimePage extends StatelessWidget {
  final Service service;

  SelectTimePage({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chọn thời gian')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Service: ${service.name}'),


          ],
        ),
      ),
    );
  }
}
