import 'package:flutter/material.dart';

import 'package:my_sales/constants.dart';

// ignore: must_be_immutable
class Tile extends StatelessWidget {
  final IconData icon;
  final List<Widget> children;
  final Color background;
  final Position itemPosition;
  EdgeInsets _margin = margin;

  // ignore: use_key_in_widget_constructors
  Tile({
    this.icon = Icons.access_time,
    this.background = Colors.red,
    this.itemPosition = Position.center,
    required this.children,
  }) {
    if (itemPosition == Position.left) {
      _margin = marginLeft;
    } else if (itemPosition == Position.right) {
      _margin = marginRight;
    }
  }

  Widget prepareTileRows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: borderRadius,
      ),
      child: prepareTileRows(),
    );
  }
}

class TileText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color foregroundColor;
  // ignore: unused_element, use_key_in_widget_constructors
  const TileText({
    required this.style,
    required this.text,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: foregroundColor,
      ),
    );
  }
}
