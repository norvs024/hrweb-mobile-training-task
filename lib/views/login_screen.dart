// lib/views/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:task/Components/login_form.dart';
import 'package:task/Components/snackbar_util.dart';
import 'package:task/controller/auth_controller.dart';
import 'package:task/views/dashboard_screen.dart';
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
      // _showMessage('Please enter both username and password');
       showSnackBar(context, "Please enter both username and password");
      return;
    }

    setState(() => _isLoading = true);

    final userModel = UserModel(username: username, password: password);
    final result = await _authController.login(userModel);

    setState(() => _isLoading = false);

    if (result['success']) {
      // Debugging SharedPreferences after login
      final isLoggedIn = await AuthController.isLoggedIn();
      print('Is Logged In after login: $isLoggedIn');
      
      if (isLoggedIn) {
        // _showMessage('Login successful');
        showSnackBar(context, "Login successful");
        // Navigator.pushReplacementNamed(context, '/dashboard');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        // _showMessage('Login failed to update session. Please try again.');
        showSnackBar(context, "Login failed to update session. Please try again.");
      }
    } else {
      // _showMessage(result['message']);
      showSnackBar(context, result['message']);

    }
  }

  // void _showMessage(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(message)),
  //   );
  // }

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
                child: Center(
                  // child: Text(
                  //   'SAMPLE LOGO',
                  //   style: TextStyle(
                  //     fontSize: 30,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  child: Image.asset('assets/logo/logo.png', 
                    // width: 390,
                    color: Colors.brown[200],
                    colorBlendMode: BlendMode.multiply,
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