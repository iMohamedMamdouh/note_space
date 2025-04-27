import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // For loading state (optional)
  bool _isLoading = false;

  // Function to handle sign-in
  void _signIn() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Validation (basic)
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Set loading state
    });

    // Call sign-in logic (e.g., Firebase Auth) here
    // For now, we'll simulate a delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // Stop loading state
      });

      // If sign-in succeeds, navigate to another screen, like a dashboard
      // For now, just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-In Successful')),
      );

      // Navigate to another screen (e.g., Home)
      // Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252525), // Set background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title (Text)
            const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40.0),

            // Email input field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),

            // Password input field
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                filled: true,
                fillColor: Colors.white,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),

            // Sign-In Button - Full Width
            _isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity, // Make the button full width
                    child: ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child:
                          const Text('Login', style: TextStyle(fontSize: 18)),
                    ),
                  ),

            const SizedBox(height: 16.0),

            // Register or Forgot Password options
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?',
                    style: TextStyle(color: Colors.white)),
                TextButton(
                  onPressed: () {
                    // Navigate to Sign Up screen (you need to implement this)
                    // Navigator.pushNamed(context, '/signUp');
                  },
                  child: const Text('Sign Up',
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Forgot your password?',
                    style: TextStyle(color: Colors.white)),
                TextButton(
                  onPressed: () {
                    // Navigate to Password Reset screen (you need to implement this)
                    // Navigator.pushNamed(context, '/resetPassword');
                  },
                  child: const Text('Reset Password',
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
