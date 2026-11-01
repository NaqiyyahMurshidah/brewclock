import 'package:flutter/material.dart';

/// Read-only card: the daily caffeine limit is fixed at 400 mg and
/// cannot be changed by the user.
class CaffeineLimitGoalCard extends StatelessWidget {
  /// Single source of truth for the daily limit (mg)
  static const int dailyLimitMg = 400;

  static const Color _cardColor = Color(0xFF30261F);
  static const Color _accentColor = Color(0xFFD8A15B);
  static const Color _secondaryText = Color(0xFFB8A99F);

  const CaffeineLimitGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.coffee_outlined, color: _accentColor),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Caffeine Limit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '$dailyLimitMg mg / day',
                  style: const TextStyle(
                    color: _accentColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Up to 400 mg of caffeine a day is generally considered '
                  'safe for most healthy adults, so this limit is fixed in '
                  'the app. Your limit may be lower if you are pregnant, '
                  'sensitive to caffeine, or have been advised otherwise by '
                  'a doctor.',
                  style: TextStyle(
                    color: _secondaryText,
                    fontSize: 13,
                    height: 1.4,
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
