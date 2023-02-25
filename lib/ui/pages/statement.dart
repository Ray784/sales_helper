import 'package:flutter/material.dart';
import 'package:my_sales/constants.dart';
import 'package:my_sales/database/connection.dart';
import 'package:my_sales/database/model/model.dart';
import 'package:my_sales/ui/elements/table.dart';
import 'package:my_sales/ui/elements/toggle_tab.dart';
import 'package:my_sales/ui/elements/tile.dart';

// ignore_for_file: use_key_in_widget_constructors
class Statement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Statement();
  }
}

class _Statement extends State<Statement> {
  List<Account> _data = [];
  double _totalPurchases = 0;
  double _totalSales = 0;
  double _totalRevenue = 0;
  bool _isLoading = false;
  final int _year = DateTime.now().year;
  int currentIndex = 4;

  getToggleTab() {
    final List<String> tabs = [
      "${_year - 4}",
      "${_year - 3}",
      "${_year - 2}",
      "${_year - 1}",
      "$_year"
    ];
    return ToggleTab(
        indices: tabs, selectedIndex: currentIndex, onPressed: _refeshData);
  }

  @override
  void initState() {
    super.initState();
    _refeshData(4);
    _removeData();
  }

  Future _refeshData(int index) async {
    DatabaseConnection database = DatabaseConnection();
    setState(() {
      _isLoading = true;
    });
    await database.refreshAccounts(_year - 4 + index);
    _data = database.getAccounts();
    _totalPurchases = database.getTotalPurchases();
    _totalRevenue = database.getTotalRevenue();
    _totalSales = database.getTotalSales();

    setState(() {
      _isLoading = false;
      currentIndex = index;
    });
  }

  Future _removeData() async {
    DatabaseConnection database = DatabaseConnection();
    for(int i = 1; i < 5; i++){
      await database.refreshAccounts(_year - 4 - i);
      List<Account> data = database.getAccounts();
      await database.removeAccounts(data);
    }
  }

  Widget _getAccounts() {
    return ListView(
      children: [
        Container(
          padding: padding,
          margin: margin,
          child: Text(
            "Account Statement",
            style:
                ubuntuStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        Container(
            padding: padding, margin: marginOnlyHor, child: getToggleTab()),
        Container(
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            color: lighterPrimary,
            borderRadius: borderRadius,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: MyTable(
              accounts: _data,
              order: Order.asc,
            ),
          ),
        ),
        Tile(
          background: darkPrimary,
          children: [
            TileText(style: subtitleStyle, text: "Total Sales"),
            TileText(style: titleStyle, text: "$rupeeSymbol $_totalSales"),
          ],
        ),
        Tile(background: darkSecondary, children: [
          TileText(style: subtitleStyle, text: "Total purchases"),
          TileText(style: titleStyle, text: "$rupeeSymbol $_totalPurchases"),
        ]),
        Tile(background: darkPrimary, children: [
          TileText(style: subtitleStyle, text: "Net revenue"),
          TileText(style: titleStyle, text: "$rupeeSymbol $_totalRevenue"),
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
    return _isLoading ? _getDialog() : _getAccounts();
  }
}
