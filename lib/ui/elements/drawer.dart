// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:my_sales/constants.dart';

class _DrawerItem extends StatelessWidget {
  final Pages header;
  final Icon icon;
  final bool isSelected;
  final Function(Pages) onTap;

  const _DrawerItem(
      {required this.header, required this.icon, this.isSelected = true, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        header.toString().split('.').last,
      ),
      onTap: isSelected? null : () {onTap(header); Navigator.pop(context);},
      tileColor: isSelected ? darkPrimary.shade900 : lighterSecondary,
      textColor: isSelected ? Colors.white : darkPrimary.shade900,
      iconColor: isSelected ? Colors.white : darkPrimary.shade900,
    );
  }
}

class AppDrawer extends StatelessWidget {
  final String title;
  final Map<Pages, Icon> tiles;
  final Pages selectedIndex;
  final Function(Pages) stateChanged;

  const AppDrawer(
      {this.title = "My Drawer",
      required this.tiles,
      required this.selectedIndex,
      required this.stateChanged});

  Widget getDrawerTitle(Color color, double height) {
    TextStyle drawerTitleStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
    );

    Text drawerTitle = Text(
      title,
      style: drawerTitleStyle,
    );

    DrawerHeader drawerHeader = DrawerHeader(
      decoration: BoxDecoration(color: color),
      margin: EdgeInsets.zero,
      child: drawerTitle,
    );

    SizedBox sizedBox = SizedBox(
      height: height,
      child: drawerHeader,
    );
    return sizedBox;
  }

  List<Widget> getDrawerTiles(BuildContext context) {
    List<Widget> drawerTiles = [
      getDrawerTitle(darkPrimary, AppBar().preferredSize.height * 2.5),
    ];
    for (MapEntry<Pages, Icon> tile in tiles.entries) {
      bool isSelected = selectedIndex == tile.key;
      drawerTiles.add(_DrawerItem(
        header: tile.key,
        icon: tile.value,
        isSelected: isSelected,
        onTap: stateChanged,
      ));
    }
    return drawerTiles;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerTiles = getDrawerTiles(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: drawerTiles,
      ),
    );
  }
}
