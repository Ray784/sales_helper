import 'package:flutter/material.dart';
import 'package:my_sales/ui/pages/app_page.dart';
import 'package:my_sales/constants.dart';

void main(List<String> args) {
  runApp(const MySales());
}

class MySales extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MySales();
  @override
  Widget build(BuildContext context) {
    return AppPage(body: Pages.dashboard);
  }
}
