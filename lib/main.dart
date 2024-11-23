import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/views/dashboard_screen.dart';
import 'package:task/views/login_screen.dart';

const String _isLoggedInKey = 'is_logged_in';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized in this zone.

    // Fetch the login state
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;

    runApp(MyApp(isLoggedIn: isLoggedIn)); // Run app in the same zone.
  }, (error, stackTrace) {
    // Catch and log any unhandled errors.
    print('Unhandled Dart Error:');
    print(error);
    print(stackTrace);
  });
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const DashboardScreen() : const LoginScreen(),
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
