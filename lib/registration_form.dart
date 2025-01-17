import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mothernameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  String _responseMessage = '';
  Future<void> register() async {
    final registrationData = {
      'name': _nameController.text,
      'mother_name': _mothernameController.text,
      'dob': _dobController.text,
      'gender': _genderController.text,
      'mobile': _mobileController.text,
      'address': _addressController.text,
      'department': _departmentController.text,
      'course': _courseController.text,
      'year': _yearController.text,
    };

    try {
      print('Sending registration data: $registrationData');
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(registrationData),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      final responseData = jsonDecode(response.body);
      setState(() {
        _responseMessage = responseData['success']
            ? 'Registration Successful!'
            : 'Registration Failed: ${responseData['message']}';
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _responseMessage = 'Error: Could not connect to the server.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextField('Name', _nameController),
              buildTextField('Mother\'s Name', _mothernameController),
              buildTextField('Date of Birth', _dobController),
              buildTextField('Gender', _genderController),
              buildTextField('Mobile Number', _mobileController),
              buildTextField('Address', _addressController),
              buildTextField('Department', _departmentController),
              buildTextField('Course', _courseController),
              buildTextField('Year', _yearController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                child: const Text('Register'),
              ),
              const SizedBox(height: 20),
              Text(
                _responseMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
