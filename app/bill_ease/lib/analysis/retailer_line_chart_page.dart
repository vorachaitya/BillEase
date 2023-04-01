// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartRetailer extends StatefulWidget {
  const LineChartRetailer({Key? key}) : super(key: key);

  @override
  State<LineChartRetailer> createState() => _LineChartRetailerState();
}

class _LineChartRetailerState extends State<LineChartRetailer> {
  @override
  void initState() {
    loadNetwork();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LineChart(
        LineChartData(lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: KJTheme.nearlyBlue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
            spots: const [
              FlSpot(1, 1),
              FlSpot(3, 1.5),
              FlSpot(5, 1.4),
              FlSpot(7, 3.4),
              FlSpot(10, 2),
              FlSpot(12, 2.2),
              FlSpot(13, 1.8),
            ],
          )
        ]),
        swapAnimationDuration: Duration(milliseconds: 150), // Optional
        swapAnimationCurve: Curves.linear, // Optional
      ),
    );
  }
}
