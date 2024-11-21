import 'package:flutter/material.dart';
import 'package:task/views/dashboard_screen.dart';
import 'package:task/views/login_screen.dart';
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
      home: const LoginScreen(),
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        '/login': (context) => const LoginScreen(),
      }
    );
  }
}


