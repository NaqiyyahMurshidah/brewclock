import 'package:flutter/material.dart';

class PreferredBedtimeCard extends StatelessWidget {
  final TimeOfDay bedtime;
  final VoidCallback onTap;

  const PreferredBedtimeCard({
    super.key,
    required this.bedtime,
    required this.onTap,
  });

  static const Color _cardColor = Color(0xFF30231D);
  static const Color _accentColor = Color(0xFFD8A15B);
  static const Color _secondaryText = Color(0xFFB8A99F);

  String _formatTime(TimeOfDay time) {
    final int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;

    final String minute = time.minute.toString().padLeft(2, '0');

    final String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(22),
            // border: Border.all(color: _accentColor.withValues(alpha: 0.22)),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(
                  //   color: _accentColor.withValues(alpha: 0.35),
                  // ),
                ),
                child: const Icon(Icons.nightlight_round, color: _accentColor),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preferred Bedtime',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Your target bedtime',
                      style: TextStyle(color: _secondaryText, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF49382E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _formatTime(bedtime),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.chevron_right, color: _accentColor),
            ],
          ),
        ),
      ),
    );
  }
}
