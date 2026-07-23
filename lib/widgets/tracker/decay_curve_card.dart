import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DecayCurveCard extends StatelessWidget {
  final List<FlSpot> spots;

  const DecayCurveCard({super.key, required this.spots});

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
            "Decay Curve",
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
            child: LineChart(_chartData(spots)),
          ), //this is where we call the chart function
        ],
      ),
    );
  }
}

LineChartData _chartData(List<FlSpot> spots) {
  return LineChartData(
    // range of sleep score
    minY: 0,
    maxY: 70,

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
      horizontalInterval: 10,
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

      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 24,

          getTitlesWidget: (value, meta) {
            return Text(
              "mg",
              style: TextStyle(color: Colors.white38, fontSize: 10),
            );
          },
        ),
      ),

      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,

          getTitlesWidget: (value, meta) {
            const times = [
              "5 PM",
              "4 PM",
              "3 PM",
              "2 PM",
              "1 PM",
              "12 PM",
              "11 AM",
            ];

            if (value < 0 || value >= times.length) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                times[value.toInt()],
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            );
          },
        ),
      ),
    ),
    lineBarsData: [
      LineChartBarData(
        spots: spots,

        isCurved: true,

        color: Colors.white,

        barWidth: 3,

        isStrokeCapRound: true,

        dotData: const FlDotData(show: false),

        belowBarData: BarAreaData(show: false),
      ),
    ],
  );
}
