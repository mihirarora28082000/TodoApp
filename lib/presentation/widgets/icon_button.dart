import 'package:flutter/material.dart';

import 'package:todoapp/presentation/constants/colors.dart';

class IconTaskButton extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final double? iconSize;
  final VoidCallback onpressedIcon;

  const IconTaskButton(
      {super.key,
      this.iconColor = white,
      required this.icon,
      this.iconSize,
      required this.onpressedIcon});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(icon, color: iconColor, size: iconSize),
        onPressed: onpressedIcon);
  }
}
