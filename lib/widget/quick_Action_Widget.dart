import 'package:flutter/material.dart';

class QuickActionWidget extends StatelessWidget {

  final String text;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap; // <-- Add this


  const QuickActionWidget({super.key, required this.text, required this.color, required this.icon, this.onTap, });

  @override
@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: onTap, // Make the whole widget tappable
    child: Container(
      width: 160,
      height: 80,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 0),
          ),
        ],
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
}
