import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  final String label;
  final int value;
  final String unit;
  final bool selected;
  final VoidCallback onTap;

  const SelectionCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),

      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white24,
        highlightColor: Colors.white10,
        onTap: onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: selected ? const Color(0xFFD8B17B) : const Color(0xFF3A291F),
            borderRadius: BorderRadius.circular(20),

            border: Border.all(
              color: selected ? const Color(0xFFD8B17B) : Colors.transparent,
              width: 2,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: selected ? const Color(0xFF1A1411) : Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    "$value ",
                    style: TextStyle(
                      color: selected ? Colors.black87 : Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                   const SizedBox(width: 2),
                  Text(
                    unit,
                    style: TextStyle(
                      color: selected ? Colors.black87 : Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
