import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.hintText,
    this.maxlines = 1,
    this.onSaved,
    this.onChanged,
    this.isRequired =
        true, // New parameter to control whether the field is required or not
  });

  final String hintText;
  final int maxlines;
  final bool isRequired; // Determines if validation should be required
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        validator: (value) {
          if (isRequired && (value?.isEmpty ?? true)) {
            return 'Please enter some text'; // Only validate if the field is required
          } else {
            return null;
          }
        },
        onChanged: onChanged,
        onSaved: onSaved,
        maxLines: maxlines,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xFF3B3B3B),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
