// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:my_sales/constants.dart';
import 'package:my_sales/database/model/model.dart';
import 'package:my_sales/ui/elements/dialog.dart';

class MyTable extends StatelessWidget {
  final List<Account> accounts;
  final Function(Account)? remove;
  final Order order;

  const MyTable({required this.accounts, this.remove, this.order = Order.desc});

  final List<DataColumn> _columns = const [
    DataColumn(label: Text("Date")),
    DataColumn(label: Text("Value($rupeeSymbol)")),
    DataColumn(label: Text("Description")),
    DataColumn(label: Text("")),
  ];

  List<DataRow> _makeRows(BuildContext context) {
    order == Order.desc
        ? accounts.sort(((b, a) => (a.dateTime).compareTo(b.dateTime)))
        : order == Order.asc
            ? accounts.sort(((a, b) => (a.dateTime).compareTo(b.dateTime)))
            : null;
    List<DataRow> rows = [];
    for (Account account in accounts) {
      List<DataCell> cells = [];
      String dateTime = account.dateTime.toString().split(" ").first;
      cells.add(DataCell(Text(dateTime)));
      cells.add(DataCell(Text("$rupeeSymbol ${account.amount}")));
      cells.add(DataCell(Text(account.description)));

      if (remove != null) {
        cells.add(DataCell(IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ConfirmDialog(
                  dialogText:
                      "Are you sure you want to delete ${account.isPurchase ? "purchase" : "sale"} - id: ${account.id}, dated: $dateTime, amount: ${account.amount}?"),
            ).then((value) {
              if (value == true) {
                remove!(account);
              }
            });
          },
          icon: const Icon(Icons.delete_outline),
          color: Colors.red,
        )));
      } else {
        cells.add(DataCell.empty);
      }
      rows.add(DataRow(cells: cells));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(columns: _columns, rows: _makeRows(context));
  }
}
