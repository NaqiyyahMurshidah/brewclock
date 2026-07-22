import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String label;
  final String title;
  final IconData icon;
  final bool backButton;

  const PageHeader({
    super.key,
    required this.label,
    required this.title,
    required this.icon,
    this.backButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (backButton)
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF3A291F),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

        if (backButton) const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        Icon(icon, color: Colors.white, size: 60),
      ],
    );
  }
}
