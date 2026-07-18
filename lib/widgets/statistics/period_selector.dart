import 'package:flutter/material.dart';

enum StatsPeriod { today, week, month }

class PeriodSelector extends StatelessWidget {
  final StatsPeriod selectedPeriod; //tells the widget which button is ctive
  final ValueChanged<StatsPeriod>
  onChanged; //tells the page user tapped another button

  const PeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF3A291F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            Expanded(
              child: _buildButton(title: "Today", period: StatsPeriod.today),
            ),

            Expanded(
              child: _buildButton(title: "Weekly", period: StatsPeriod.week),
            ),

            Expanded(
              child: _buildButton(title: "Monthly", period: StatsPeriod.month),
            ),
          ],
        ),
      ),
    );
  }

  //builbutton method
  Widget _buildButton({required String title, required StatsPeriod period}) {
    final bool selected = period == selectedPeriod;

    return GestureDetector(
      onTap: () => onChanged(period),

      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected 
          ? const Color(0xFFD8B17B)
          : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? const Color(0xFF1A1411)
                : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      ),
    );
  }
}
