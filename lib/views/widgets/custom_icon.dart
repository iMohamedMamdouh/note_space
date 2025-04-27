import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, required this.onPressed});
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 45,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}
