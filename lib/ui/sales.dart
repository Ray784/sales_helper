import 'package:flutter/material.dart';
import 'package:my_sales/constants.dart';
import 'package:my_sales/ui/elements/tile.dart';

// ignore: use_key_in_widget_constructors
class Sales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: padding,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(ubuntuStyle),
              ),
              child: Text(
                "Click me",
                style: subtitleStyle.copyWith(color: Colors.white),
              ),
            )),
        Tile(
          background: darkPrimary,
          children: [
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Click me",
                  style: subtitleStyle.copyWith(color: Colors.white),
                ))
          ],
        ),
      ],
    );
  }
}
