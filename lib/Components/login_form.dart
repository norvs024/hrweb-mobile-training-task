// lib/views/widgets/login_form.dart
import 'package:flutter/material.dart';
import '../components/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onFacebookSignIn;
  final VoidCallback onForgotPassword;

  const LoginForm({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.isLoading,
    required this.onLogin,
    required this.onGoogleSignIn,
    required this.onFacebookSignIn,
    required this.onForgotPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    bool _isPasswordVisible = false;
    

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      color: Colors.brown[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.02),

          CustomTextField(
            labelText: 'Username',
            prefixIcon: Icons.person,
            controller: usernameController,
          ),
          SizedBox(height: screenHeight * 0.02),

          CustomTextField(
            obscureText: !_isPasswordVisible,
            labelText: 'Password',
            prefixIcon: Icons.lock,
            controller: passwordController,
            
          ),
          SizedBox(height: screenHeight * 0.02),

          _buildLoginButton(),
          _buildForgotPasswordButton(),
          _buildDivider(),
          SizedBox(height: screenHeight * 0.03),
          _buildSigninWithGoogle(),
          SizedBox(height: screenHeight * 0.02),
          _buildSigninWithFacebook(),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: isLoading ? null : onLogin,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text(
              'Login',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: onForgotPassword,
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.brown),
      ),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: Colors.black)),
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
        Expanded(child: Divider(thickness: 1, color: Colors.black)),
      ],
    );
  }

  Widget _buildSigninWithGoogle() {
    return 
        ElevatedButton.icon(
          onPressed: onGoogleSignIn,
          icon: const Icon(Icons.email, color: Colors.white),
          label: const Text(
            'Sign in with Google',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
  }

   Widget _buildSigninWithFacebook() {
    return   
        ElevatedButton.icon(
          onPressed: onFacebookSignIn,
          icon: const Icon(Icons.facebook, color: Colors.white),
          label: const Text(
            'Sign in with Facebook',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[800],
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
  }
}