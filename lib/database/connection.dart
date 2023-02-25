import 'package:my_sales/constants.dart';
import 'package:my_sales/database/database.dart';
import 'package:my_sales/database/model/model.dart';
import 'package:my_sales/ui/elements/bar_chart.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class DatabaseConnection {
  List<Account> _accounts = [];
  double _totalRevenue = 0;
  double _totalSales = 0;
  double _totalPurchases = 0;

  List<Bar> getMonthlyRevenueBars() {
    List<Bar> revenue = [];
    for (Month month in Month.values) {
      double monthRevenue = 0;
      for (Account account in _accounts) {
        if (account.dateTime.month - 1 == month.index) {
          if (account.isPurchase) {
            monthRevenue -= account.amount;
            _totalPurchases += account.amount;
          } else {
            monthRevenue += account.amount;
            _totalSales += account.amount;
          }
        }
      }
      _totalRevenue += monthRevenue;
      revenue.add(Bar(
          month: month,
          amount: monthRevenue,
          barColor: charts.ColorUtil.fromDartColor(darkPrimary.shade400)));
    }
    return revenue;
  }

  List<Account> getSales() {
    return _accounts;
  }

  List<Account> getAccounts() {
    for (Account account in _accounts) {
      if(account.isPurchase) {
        _totalPurchases += account.amount;
      } else {
        _totalSales += account.amount;
      }
    }
    _totalRevenue = _totalSales - _totalPurchases;
    return _accounts;
  }

  List<Account> getPurchases() {
    List<Account> purchases = [];
    for (Account account in _accounts) {
      if(account.isPurchase) {
        purchases.add(account);
      }
    }
    return purchases;
  }

  double getTotalRevenue() {
    return _totalRevenue;
  }

  double getTotalSales() {
    return _totalSales;
  }

  double getTotalPurchases() {
    return _totalPurchases;
  }

  Future addAccount(Account account) async {
    await AccountsDatabase.instance.insertAccount(account);
  }

  Future removeAccount(Account account) async {
    await AccountsDatabase.instance.deleteAccount(account);
  }

  Future removeAccounts(List<Account> accounts) async {
    for(Account account in accounts){
      await removeAccount(account);
    }
  }

  Future refreshAccounts(int year) async {
    _accounts = await AccountsDatabase.instance.getYearAccounts(year);
  }
}
