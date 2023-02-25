import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const AppDrawer(
      {this.title = "My Drawer", this.children = const [], Key? key})
      : super(key: key);

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
      child: drawerTitle,
    );

    SizedBox sizedBox = SizedBox(
      height: height,
      child: drawerHeader,
    );
    return sizedBox;
  }

  List<Widget> getDrawerTiles(color) {
    return [
      getDrawerTitle(color, AppBar().preferredSize.height * 2.5),
      ListTile(
        leading: const Icon(Icons.dashboard_outlined),
        title: const Text('Dashboard'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.store_mall_directory_outlined),
        title: const Text('Sales'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.shopping_bag_outlined),
        title: const Text('Purchases'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.account_balance_outlined),
        title: const Text('Statement'),
        onTap: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerTiles =
        getDrawerTiles(Theme.of(context).primaryColor);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: drawerTiles,
      ),
    );
  }
}
