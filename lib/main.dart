import 'package:flutter/material.dart';
import 'login.dart'; // Import the LoginPage
//import 'registration_form.dart'; // Import the Registration page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(), // Set LoginPage as the home screen
    );
  }
}

// Example LoginPage with navigation to Registration

