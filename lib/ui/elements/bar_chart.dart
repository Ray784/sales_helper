import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:my_sales/constants.dart';

class Bar {
  final Month month;
  final double amount;
  final charts.Color barColor;

  Bar({required this.month, required this.amount, required this.barColor});
}

class BarChart extends StatelessWidget {
  final List<Bar> data;
  final String header;
  // ignore: use_key_in_widget_constructors
  const BarChart({required this.data, required this.header});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Bar, String>> series = [
      charts.Series(
          id: "sale",
          data: data,
          domainFn: (Bar series, _) =>
              series.month.toString().split('.').last,
          measureFn: (Bar series, _) => series.amount,
          colorFn: (Bar series, _) => series.barColor)
    ];
    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(header),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
