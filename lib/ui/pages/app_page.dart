// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:my_sales/constants.dart';
import 'package:my_sales/ui/elements/drawer.dart';
import 'package:my_sales/ui/pages/dashboard.dart';
import 'package:my_sales/ui/pages/purchases.dart';
import 'package:my_sales/ui/pages/sales.dart';
import 'package:my_sales/ui/pages/statement.dart';

// ignore: must_be_immutable
class AppPage extends StatefulWidget {
  Pages body;

  AppPage({required this.body});

  @override
  State<StatefulWidget> createState() {
    return _AppPage();
  }
}

class _AppPage extends State<AppPage> {
  _AppPage();

  setBody(Pages page) {
    setState(() {
      widget.body = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Map<Pages, Icon> tileMap = {
      Pages.dashboard: Icon(Icons.dashboard_outlined),
      Pages.purchases: Icon(Icons.shopping_bag_outlined),
      Pages.sales: Icon(Icons.store_mall_directory_outlined),
      Pages.statement: Icon(Icons.account_balance_outlined),
    };

    Map<Pages, Widget> widgetMap = {
      Pages.dashboard: Dashboard(),
      Pages.sales: Sales(),
      Pages.purchases: Purchases(),
      Pages.statement: Statement(),
    };

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: darkPrimary,
        textTheme: TextTheme(
            bodyLarge: ubuntuStyle,
            bodyMedium: ubuntuStyle,
            displaySmall: ubuntuStyle,
            displayMedium: ubuntuStyle,
            headlineMedium: ubuntuStyle,
            headlineSmall: ubuntuStyle,
            titleLarge: ubuntuStyle,
            displayLarge: ubuntuStyle),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SalesFactor"),
        ),
        drawer: AppDrawer(
          title: "SalesFactor",
          tiles: tileMap,
          selectedIndex: widget.body,
          stateChanged: setBody,
        ),
        body: widgetMap[widget.body],
      ),
    );
  }
}
