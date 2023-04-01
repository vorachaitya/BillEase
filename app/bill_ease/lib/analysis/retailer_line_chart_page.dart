import 'package:bill_ease/utils/kj_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartRetailer extends StatefulWidget {
  const LineChartRetailer(this.pointPlts, {Key? key}) : super(key: key);
  final pointPlts;

  @override
  State<LineChartRetailer> createState() => _LineChartRetailerState();
}

class _LineChartRetailerState extends State<LineChartRetailer> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(lineBarsData: [
        LineChartBarData(
          isCurved: true,
          color: KJTheme.nearlyBlue,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: widget.pointPlts as List<FlSpot>,
        )
      ]),
      swapAnimationDuration: const Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }
}
