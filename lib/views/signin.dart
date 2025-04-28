import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_space/views/notes_view.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _signIn() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Use signInWithEmailAndPassword for existing users
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-In Successful')),
      );

      // Navigate to the NotesView screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NotesView()),
      );
    }).catchError((e) {
      setState(() {
        _isLoading = false;
      });

      // Handle sign-in error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-In Failed: ${e.toString()}')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252525),
      body: Center(
        // Use Center widget to align all items
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true, // Ensure the ListView wraps its content
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center the text
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Enter your email and password',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center, // Center the text
              ),
              const SizedBox(height: 40.0),

              // Email input
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 1),
                  labelText: 'Email',
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8.0),

              // Password input with "Forgot Password?"
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 1),
                  labelText: 'Password',
                  suffix: TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/resetPassword');
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),

              // Sign-In button
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _signIn();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                        ),
                        child:
                            const Text('Login', style: TextStyle(fontSize: 22)),
                      ),
                    ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?',
                      style: TextStyle(color: Colors.white)),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign-Up screen
                      Navigator.pushReplacementNamed(context, '/signUp');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Sign In with',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset("assets/images/logos_facebook.png"),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset("assets/images/logos_linkedin-icon.png"),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon:
                          Image.asset("assets/images/grommet-icons_google.png"))
                ],
              ),
              const SizedBox(height: 40.0),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Skip now -->'))
            ],
          ),
        ),
      ),
    );
  }
}
