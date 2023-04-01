// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:bill_ease/utils/kj_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LineChartCustomer extends StatefulWidget {
  const LineChartCustomer(this.pointPlts, {Key? key}) : super(key: key);
  final pointPlts;

  @override
  State<LineChartCustomer> createState() => _LineChartCustomerState();
}

class _LineChartCustomerState extends State<LineChartCustomer> {
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    Fluttertoast.showToast(msg: value.toString());
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          // titlesData: FlTitlesData(
          //     bottomTitles: AxisTitles(
          //   sideTitles: SideTitles(
          //     showTitles: true,
          //     reservedSize: 32,
          //     interval: 1,
          //     getTitlesWidget: bottomTitleWidgets,
          //   ),
          // )),
          lineBarsData: [
            LineChartBarData(
              show: true,
              isCurved: true,
              shadow: Shadow(),
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
