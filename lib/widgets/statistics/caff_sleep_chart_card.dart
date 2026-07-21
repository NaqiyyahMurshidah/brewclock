import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CaffSleepChartCard extends StatelessWidget {
  final List<FlSpot> caffeineSpots;
  final List<FlSpot> sleepSpots;

  const CaffSleepChartCard({
    super.key,
    required this.caffeineSpots,
    required this.sleepSpots,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Color(0xFF3B2A20),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            " Caffeine vs Sleep",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          //CHART
          SizedBox(
            height: 220,
            child: LineChart(_chartData(caffeineSpots, sleepSpots)),
          ), //this is where we call the chart function
        ],
      ),
    );
  }
}

LineChartData _chartData(List<FlSpot> caffeineSpots, List<FlSpot> sleepSpots) {
  return LineChartData(
    // range of sleep score
    minY: 0,
    maxY: 140,

    minX: 0,
    maxX: 6,

    //remove border
    borderData: FlBorderData(show: false),

    clipData: const FlClipData.all(),

    //show grid lines
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      drawHorizontalLine: true,
      horizontalInterval: 35,
      verticalInterval: 1,

      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.white.withOpacity(.08),
          strokeWidth: 1,
          dashArray: [5, 5],
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Colors.white.withOpacity(.08),
          strokeWidth: 1,
          dashArray: [5, 5],
        );
      },
    ),

    // Axis titles
    titlesData: FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 25,
          reservedSize: 30,

          getTitlesWidget: (value, meta) {
            final sleepScore = (value / 140 * 100).round();

            return Text(
              sleepScore.toString(),
              style: const TextStyle(color: Colors.cyan, fontSize: 10),
            );
          },
        ),
      ),

      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 35,
          reservedSize: 30,

          getTitlesWidget: (value, meta) {
            return Text(
              value.toInt().toString(),
              style: const TextStyle(color: Color(0xFFD8B17B), fontSize: 10),
            );
          },
        ),
      ),

      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,

          getTitlesWidget: (value, meta) {
            const days = ["M", "T", "W", "T", "F", "S", "S"];

            if (value < 0 || value >= days.length) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                days[value.toInt()],
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            );
          },
        ),
      ),
    ),
    lineBarsData: [
      LineChartBarData(
        spots: caffeineSpots,
        isCurved: true,
        color: const Color(0xFFD8B17B),
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
      LineChartBarData(
        spots: sleepSpots,
        isCurved: true,
        color: Colors.cyan,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
    ],
  );
}
