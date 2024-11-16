import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Index(),
    );
  }
}

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    // Enable fullscreen mode (status bar and navigation bar hidden)
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Get screen height and width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First container for the logo or introductory text
              Container(
                height: screenHeight * 0.25, // 25% of the screen height
                color: Colors.brown[200],
                padding: const EdgeInsets.all(20),
                child: const Center(
                  child: Text(
                    'LOGO TEST',
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
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02), // 2% of screen height

                    // Password Input
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02), // 2% of screen height

                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        // Handle login logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
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
