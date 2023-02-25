import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PurchasesTile();
  }

  Widget getDashboardItem() {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          getDashboardTitle("shdg"),
          getDashboardTitle("hsgfgas"),
          getDashboardTitle("ahgva")
        ],
      ),
    );
  }

  Widget getDashboardTitle(String title) {
    TextStyle dashboardTitleStyle = const TextStyle(
      color: Colors.black,
      fontSize: 24,
    );

    Text dashboardText = Text(
      title,
      style: dashboardTitleStyle,
    );

    Padding dashboardItem = Padding(
      padding: const EdgeInsets.all(10),
      child: dashboardText,
    );

    return dashboardItem;
  }
}

class _PurchasesTile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return 
Column(children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Wallet balance',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          height: 1.5,
                        ).copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '₹ 56,439.00',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          height: 2,
                        ).copyWith(
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ]
              )
            )
        ]);
  }
}
