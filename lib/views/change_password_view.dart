import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // For loading state
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Old Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                ),
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              if (_isLoading) const CircularProgressIndicator(),
              if (_errorMessage.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              ElevatedButton(
                onPressed: _isLoading ? null : _changePassword,
                child: const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // User not logged in
        setState(() {
          _errorMessage = 'No user logged in!';
        });
        return;
      }

      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        // Re-authenticate the user with their current password
        final authCredential = EmailAuthProvider.credential(
          email: currentUser.email!,
          password: _oldPasswordController.text,
        );

        await currentUser.reauthenticateWithCredential(authCredential);

        // If re-authentication is successful, update the password
        await currentUser.updatePassword(_newPasswordController.text);

        // Success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password successfully updated!')),
        );

        // Return to the previous screen (or log out if desired)
        Navigator.pop(context);
      } catch (e) {
        // Handle errors (incorrect password, etc.)
        setState(() {
          _errorMessage =
              'Failed to change password: old password is incorrect.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
