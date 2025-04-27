import 'package:flutter/material.dart';
import 'package:note_space/views/widgets/custom_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.icon3,
    this.icon,
    required this.icon2,
    this.onPressed,
  });

  final String title;
  final IconData? icon;
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
        if (icon != null) CustomIcon(onPressed: onPressed, icon: icon!),
        CustomIcon(onPressed: onPressed, icon: icon2),
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
