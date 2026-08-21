import 'package:flutter/material.dart';

class GoalsSummaryCards extends StatelessWidget {
  final int caffeineLimit;
  final int sleepGoal;

  const GoalsSummaryCards({
    super.key,
    required this.caffeineLimit,
    required this.sleepGoal,
  });

  static const Color _cardColor = Color(0xFF30231D);
  static const Color _accentColor = Color(0xFFD8A15B);
  static const Color _secondaryText = Color(0xFFB8A99F);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            icon: Icons.coffee_rounded,
            label: 'Caffeine limit',
            value: '$caffeineLimit mg',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            icon: Icons.nightlight_round,
            label: 'Sleep target',
            value: '$sleepGoal h',
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: GoalsSummaryCards._cardColor,
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(
        //   color: GoalsSummaryCards._accentColor.withValues(alpha: 0.25),
        // ),
      ),
      child: Row(
        children: [
          Icon(icon, color: GoalsSummaryCards._accentColor, size: 31),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: GoalsSummaryCards._secondaryText,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
