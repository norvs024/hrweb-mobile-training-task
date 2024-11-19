import 'package:flutter/material.dart';
import 'package:task/dashboard.dart';
import 'package:task/login.dart';
// import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
      routes: {
        '/dashboard': (context) => const Dashboard(),
        '/login': (context) => const Login(),
      }
    );
  }
}


