// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:my_sales/database/connection.dart';
import 'package:my_sales/database/model/model.dart';
import 'package:my_sales/ui/elements/add_sale_purchase.dart';
import 'package:my_sales/constants.dart';
import 'package:my_sales/ui/elements/table.dart';

class Sales extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Sales();
  }
}

class _Sales extends State<Sales> {
  List<Account> _data = [];
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
    _data = database.getSales();
    setState(() {
      _isLoading = false;
    });
  }

  Future _addAccount(Account account) async {
    DatabaseConnection database = DatabaseConnection();
    await database.addAccount(account);
    await _refeshData();
  }

  Future _removeAccount(Account account) async {
    DatabaseConnection database = DatabaseConnection();
    await database.removeAccount(account);
    await _refeshData();
  }

  Widget _getSales() {
    return ListView(
      children: [
        Container(
          padding: padding,
          margin: margin,
          child: Text(
            "My Sales",
            style:
                ubuntuStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        Container(
            padding: padding.copyWith(right: 10, left: 10),
            margin: margin,
            decoration: BoxDecoration(
              color: darkSecondary,
              borderRadius: borderRadius,
            ),
            child: SalePurchaseForm(onStateChange: _addAccount, isSale: true)),
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
              remove: _removeAccount,
            ),
          ),
        ),
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
    return _isLoading ? _getDialog() : _getSales();
  }
}
