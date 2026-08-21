import 'package:flutter/material.dart';

class SleepGoalCard extends StatelessWidget {
  final int sleepGoal;
  final ValueChanged<int> onChanged;

  const SleepGoalCard({
    super.key,
    required this.sleepGoal,
    required this.onChanged,
  });

  static const Color _backgroundColor = Color(0xFF1A1411);
  static const Color _cardColor = Color(0xFF30231D);
  static const Color _accentColor = Color(0xFFD8A15B);
  static const Color _secondaryText = Color(0xFFB8A99F);

  @override
  Widget build(BuildContext context) {
    const List<int> options = [6, 7, 8, 9];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(22),
        // border: Border.all(color: _accentColor.withValues(alpha: 0.22)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const _SleepIcon(),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sleep Goal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Target sleep duration',
                      style: TextStyle(color: _secondaryText, fontSize: 13),
                    ),
                  ],
                ),
              ),
              _SleepValuePill(text: '$sleepGoal hours'),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: options.map((hours) {
              final bool selected = sleepGoal == hours;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: hours == options.last ? 0 : 8,
                  ),
                  child: InkWell(
                    onTap: () => onChanged(hours),
                    borderRadius: BorderRadius.circular(14),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      height: 46,
                      decoration: BoxDecoration(
                        color: selected ? _accentColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        // border: Border.all(
                        //   color: selected
                        //       ? _accentColor
                        //       : const Color(0xFF695044),
                        // ),
                      ),
                      child: Center(
                        child: Text(
                          '${hours}h',
                          style: TextStyle(
                            color: selected ? _backgroundColor : _secondaryText,
                            fontSize: 15,
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SleepIcon extends StatelessWidget {
  const _SleepIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // border: Border.all(
        //   color: SleepGoalCard._accentColor.withValues(alpha: 0.35),
        // ),
      ),
      child: const Icon(Icons.bed_outlined, color: SleepGoalCard._accentColor),
    );
  }
}

class _SleepValuePill extends StatelessWidget {
  final String text;

  const _SleepValuePill({required this.text});

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
