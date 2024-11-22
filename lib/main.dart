import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task/views/dashboard_screen.dart';
import 'package:task/views/login_screen.dart';
// import 'package:flutter/services.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    print('Unhandled Flutter Error:');
    print(details.exceptionAsString());
    print(details.stack);
  };

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stackTrace) {
    print('Unhandled Dart Error:');
    print(error);
    print(stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: const LoginScreen(),
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/login': (context) => const LoginScreen(),
      }
    );
  }
}


