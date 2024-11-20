// lib/views/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:task/Components/login_form.dart';
import 'package:task/controller/auth_controller.dart';
import '../../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showMessage('Please enter both username and password');
      return;
    }

    setState(() => _isLoading = true);

    final userModel = UserModel(username: username, password: password);
    final result = await _authController.login(userModel);

    setState(() => _isLoading = false);

    if (result['success']) {
      // Handle successful login
      _showMessage('Login successful');
      // Navigate to dashboard
      // Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      _showMessage(result['message']);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
              Container(
                height: screenHeight * 0.25,
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
              LoginForm(
                usernameController: _usernameController,
                passwordController: _passwordController,
                isLoading: _isLoading,
                onLogin: _handleLogin,
                onGoogleSignIn: () {
                  // Implement Google sign-in
                },
                onFacebookSignIn: () {
                  // Implement Facebook sign-in
                },
                onForgotPassword: () {
                  // Implement forgot password
                },
              ),
              // Second container for the login form or other content
   
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}