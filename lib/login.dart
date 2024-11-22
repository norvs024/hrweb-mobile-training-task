import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task/Components/custom_text_field.dart'; // Assuming you already have this custom widget
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // To show loading indicator when logging in

  // Function to handle login request
  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print(username);
    print(password);

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both username and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Show loading spinner while logging in
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/task2/public/loginPage'),// Replace with your actual API URL
        headers: <String, String>{
         'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
        body: {
          'userName': username,  // The name of the field expected by your backend
          'pass': password,  // The password field
        },
        ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Connection timed out');
        },
      );

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}');

      setState(() {
        _isLoading = false; // Hide loading spinner
      });

      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        var data = jsonDecode(response.body);
        // if (data['success'] == true) {
        //   // Login successful
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Login successful')),
        //   );
        //   Navigator.pushReplacementNamed(context, '/dashboard'); // Navigate to the dashboard
        // } else {
        //   // Invalid username or password
        //   print(username);
        //   print(password);
        //   print('Login failed: ${data['message']}');
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Login failed: ${data['message']}')),
        //   );
        // }
        if (data['success']) {
      
          // Handle successful login (Navigate to dashboard or store user info)
        } else {
          print('Login failed: ${data['message']}');
          // Show error message (e.g., wrong password or username not found)
        }
      } else {
        // Server error
        // print(username);
        // print(password);
        // print('Server error: ${response.statusCode}');
         // Handle server errors (non-200 responses)
      print('Server error: ${response.statusCode}');
        
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Server error: ${response.statusCode}')),
        // );
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Hide loading spinner on error
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('An error occurred: $e')),
      // );
       print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.brown[200],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First container for the logo or introductory text
              Container(
                height: screenHeight * 0.25, // 25% of the screen height
                color: Colors.brown[200],
                child: const Center(
                  child: Text(
                    'SAMPLE LOGO',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Second container for the login form or other content
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                color: Colors.brown[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // LOGIN Text
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.02), // 2% of screen height

                    // Username Input
                    CustomTextField(
                      labelText: 'Username',
                      prefixIcon: Icons.person,
                      controller: _usernameController, // Pass controller here
                    ),
                    SizedBox(height: screenHeight * 0.02), // 2% of screen height

                    // Password Input
                    CustomTextField(
                      // obscureText: true,
                      labelText: 'Password',
                      prefixIcon: Icons.lock,
                      controller: _passwordController, // Pass controller here
                    ),
                    SizedBox(height: screenHeight * 0.02), // 2% of screen height

                    // Login Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _login, // Disable button while loading
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),

                    SizedBox(height: screenHeight * 0.01), // 1% of screen height

                    // Forgot Password
                    TextButton(
                      onPressed: () {
                        // Handle forgot password logic here
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.brown,
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03), // 3% of screen height

                    // Divider line with an "Or" text in the center
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Or Sign in With',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.black),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.03), // 3% of screen height

                    // Google Sign-In Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle Google sign-in logic here
                      },
                      icon: const Icon(Icons.email, color: Colors.white),
                      label: const Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Google blue color
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02), // 2% of screen height

                    // Facebook Sign-In Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle Facebook sign-in logic here
                      },
                      icon: const Icon(Icons.facebook, color: Colors.white),
                      label: const Text(
                        'Sign in with Facebook',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800], // Facebook color
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
