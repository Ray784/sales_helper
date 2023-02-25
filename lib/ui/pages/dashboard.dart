// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:my_sales/database/connection.dart';
import 'package:my_sales/database/model/model.dart';

import 'package:my_sales/ui/elements/bar_chart.dart';
import 'package:my_sales/constants.dart';
import 'package:my_sales/ui/elements/tile.dart';
import 'package:my_sales/ui/elements/add_value.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  List<Bar> _data = [];
  double _revenue = 0;
  double _sales = 0;
  double _purchases = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _refeshData();
  }

  Future _refeshData() async {
    DatabaseConnection database = DatabaseConnection();
    setState(() {
      _isLoading = true;
    });
    await database.refreshAccounts(DateTime.now().year);
    _data = database.getMonthlyRevenueBars();
    _revenue = database.getTotalRevenue();
    _sales = database.getTotalSales();
    _purchases = database.getTotalPurchases();
    setState(() {
      _isLoading = false;
    });
  }

  Future _addAccount(Account account) async {
    DatabaseConnection database = DatabaseConnection();
    await database.addAccount(account);
    await _refeshData();
  }

  Widget _getDashboard() {
    _data.sort(((a, b) => (a.month.index).compareTo(b.month.index)));
    return ListView(
      children: [
        BarChart(data: _data, header: "Monthly Revenue",),
        Container(
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            color: darkSecondary,
            borderRadius: borderRadius,
          ),
          child: ValueForm(onStateChange: _addAccount,),
        ),
        Tile(
          background: darkPrimary,
          children: [
            TileText(style: subtitleStyle, text: "Total Sales"),
            TileText(style: titleStyle, text: "$rupeeSymbol $_sales"),
          ],
        ),
        Tile(background: darkSecondary, children: [
          TileText(style: subtitleStyle, text: "Total purchases"),
          TileText(style: titleStyle, text: "$rupeeSymbol $_purchases"),
        ]),
        Tile(background: darkPrimary, children: [
          TileText(style: subtitleStyle, text: "Net revenue"),
          TileText(style: titleStyle, text: "$rupeeSymbol $_revenue"),
        ]),
      ],
    );
  }

  Widget _getDialog() {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              height: 15,
            ),
            Text("Loading...")
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? _getDialog() : _getDashboard();
  }
}
