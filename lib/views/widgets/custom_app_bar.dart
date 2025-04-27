import 'package:flutter/material.dart';
import 'package:note_space/views/task_screen.dart';
import 'package:note_space/views/widgets/custom_icon.dart'; // Import the SearchNotesView

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.icon3,
    this.icon1,
    required this.icon2,
    this.onPressed,
  });

  final String title;
  final IconData? icon1;
  final IconData? icon3;
  final IconData icon2;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
          ),
        ),
        if (icon1 != null) CustomIcon(onPressed: onPressed, icon: icon1!),
        IconButton(
          onPressed: () {
            // Navigate to TaskScreen when icon2 is clicked
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const TaskScreen()), // Navigate to TaskScreen
            );
          },
          icon: Icon(icon2),
        ),
        if (icon3 != null)
          IconButton(
            icon: Icon(icon3),
            onPressed: () {
              Scaffold.of(context)
                  .openDrawer(); // Open the drawer when icon3 is clicked
            },
          ),
      ],
    );
  }
}
