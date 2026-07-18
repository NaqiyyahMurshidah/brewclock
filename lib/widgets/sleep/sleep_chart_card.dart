import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepChartCard extends StatelessWidget {
  const SleepChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF3B2A20),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "7 Day Quality Score",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          //CHART
          SizedBox(height: 220, child: LineChart(_chartData())),
        ],
      ),
    );
  }
}

LineChartData _chartData() {
  return LineChartData(
    // range of sleep score
    minY: 0,
    maxY: 100,

    //remove border
    borderData: FlBorderData(show: false),

    //show grid lines
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 20,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(color: Colors.white.withValues(alpha: 0.08), strokeWidth: 1);
      },
      getDrawingVerticalLine: (value) {
        return FlLine(color: Colors.white.withValues(alpha: 0.08), strokeWidth: 1);
      },
    ),

    // Axis titles
    titlesData: FlTitlesData(
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,

          getTitlesWidget: (value, meta) {
            const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

            if (value < 0 || value >= days.length) {
              return const SizedBox.shrink();
            }

             return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                days[value.toInt()],
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            );
          },
        ),
      ),
    ),
    lineBarsData: [
      LineChartBarData(
        isCurved: true,
        color: const Color(0xFFD8B17B),
        barWidth: 4,
        isStrokeCapRound: true,

        dotData: const FlDotData(show: true),

        belowBarData: BarAreaData(show: false),

        spots: const [
          FlSpot(0, 82),
          FlSpot(1, 90),
          FlSpot(2, 75),
          FlSpot(3, 88),
          FlSpot(4, 95),
          FlSpot(5, 92),
          FlSpot(6, 98),
        ],
      ),
    ],
  );
}
