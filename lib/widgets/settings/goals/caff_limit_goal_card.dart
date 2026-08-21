import 'package:flutter/material.dart';

class CaffeineLimitGoalCard extends StatelessWidget {
  final double caffeineLimit;
  final ValueChanged<double> onChanged;

  const CaffeineLimitGoalCard({
    super.key,
    required this.caffeineLimit,
    required this.onChanged,
  });

  static const Color _cardColor = Color(0xFF30231D);
  static const Color _accentColor = Color(0xFFD8A15B);
  static const Color _secondaryText = Color(0xFFB8A99F);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _decoration(),
      child: Column(
        children: [
          Row(
            children: [
              const _CaffeineIcon(),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Caffeine Limit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Maximum caffeine per day',
                      style: TextStyle(color: _secondaryText, fontSize: 13),
                    ),
                  ],
                ),
              ),
              _ValuePill(text: '${caffeineLimit.round()} mg'),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _accentColor,
              inactiveTrackColor: const Color(0xFF5A493D),
              thumbColor: _accentColor,
              overlayColor: _accentColor.withValues(alpha: 0.15),
              trackHeight: 4,
            ),
            child: Slider(
              value: caffeineLimit,
              min: 100,
              max: 500,
              divisions: 8,
              onChanged: onChanged,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '100 mg',
                  style: TextStyle(color: _secondaryText, fontSize: 12),
                ),
                Text(
                  '500 mg',
                  style: TextStyle(color: _secondaryText, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: _cardColor,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: _accentColor.withValues(alpha: 0.22)),
    );
  }
}

class _CaffeineIcon extends StatelessWidget {
  const _CaffeineIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: CaffeineLimitGoalCard._accentColor.withValues(alpha: 0.35),
        ),
      ),
      child: const Icon(
        Icons.coffee_rounded,
        color: CaffeineLimitGoalCard._accentColor,
      ),
    );
  }
}

class _ValuePill extends StatelessWidget {
  final String text;

  const _ValuePill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFF49382E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
