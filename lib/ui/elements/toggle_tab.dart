// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_sales/constants.dart';

class ToggleTab extends StatefulWidget {
  int selectedIndex;
  List<String> indices;
  void Function(int)? onPressed;

  ToggleTab({Key? key, this.selectedIndex = 0, required this.indices, this.onPressed}) : super(key: key) {
    if (selectedIndex >= indices.length) {
      selectedIndex %= indices.length;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _TabState();
  }
}

class _TabState extends State<ToggleTab> {
  List<_TabData> _labels = [];

  void _makeLables() {
    _labels = [];
    for (int i = 0; i < widget.indices.length; i++) {
      _labels.add(_TabData(
          data: widget.indices[i], isSelected: i == widget.selectedIndex));
    }
  }

  @override
  Widget build(BuildContext context) {
    _makeLables();
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        height: 36,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _TabButton(
              firstLast: (index == 0)
                  ? 0
                  : (index == _labels.length - 1)
                      ? 1
                      : -1,
              child: _labels[index],
              onPressed: () {
                setState(() {
                  widget.selectedIndex = index;
                });
                if(widget.onPressed != null){
                  widget.onPressed!(widget.selectedIndex);
                }
              },
            );
          },
          itemCount: _labels.length,
          scrollDirection: Axis.horizontal,
        ));
  }
}

class _TabData extends StatelessWidget {
  bool isSelected;
  String data;
  _TabData({this.isSelected = false, required this.data});
  final TextStyle _isSelectedStyle =
      ubuntuStyle.copyWith(color: lighterPrimary);
  final TextStyle _isNotSelectedStyle =
      ubuntuStyle.copyWith(color: darkPrimary);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: isSelected ? _isSelectedStyle : _isNotSelectedStyle,
    );
  }
}

RoundedRectangleBorder _firstButtonShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)));
RoundedRectangleBorder _lastButtonShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(10), bottomRight: Radius.circular(10)));
RoundedRectangleBorder _buttonShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(0)));

class _TabButton extends StatelessWidget {
  _TabData child;
  void Function()? onPressed;
  final int firstLast;
  _TabButton(
      {required this.child, required this.onPressed, this.firstLast = -1});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          backgroundColor: child.isSelected ? darkPrimary : lighterPrimary,
          animationDuration: Duration.zero,
          shape: (firstLast == 0)
              ? _firstButtonShape
              : (firstLast == 1)
                  ? _lastButtonShape
                  : _buttonShape),
      child: child,
    );
  }
}
