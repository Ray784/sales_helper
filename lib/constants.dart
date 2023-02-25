import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// string constants
const String rupeeSymbol = "₹";

// margins
const EdgeInsets marginRight =
    EdgeInsets.only(left: 5, bottom: 10, top: 10, right: 10);
const EdgeInsets marginLeft =
    EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 5);
const EdgeInsets margin = EdgeInsets.all(10);
const EdgeInsets marginOnlyHor = EdgeInsets.only(left: 10, right: 10);
const EdgeInsets marginOnlyVer = EdgeInsets.only(bottom: 10, top: 10,);

const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 12);

const double borderRadiusValue = 15;
final BorderRadius borderRadius = BorderRadius.circular(borderRadiusValue);

// enums
enum Position { left, right, center }
enum Order { asc, desc, dbs }
enum Month { jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec }
enum Pages { dashboard, sales, statement, purchases }

TextStyle titleStyle = GoogleFonts.ubuntu(
  fontWeight: FontWeight.bold,
  fontSize: 26,
  height: 1.5,
);

TextStyle subtitleStyle = GoogleFonts.ubuntu(
  fontWeight: FontWeight.normal,
  fontSize: 16,
  height: 1,
);

TextStyle ubuntuStyle = GoogleFonts.ubuntu();

// colors
const int _darkPrimaryValue = 0xFF1a1d21;
const MaterialColor darkPrimary = MaterialColor(
  _darkPrimaryValue,
  <int, Color>{
    050: Color(0xFF8D8E90),
    100: Color(0xFF76777A),
    200: Color(0xFF5F6164),
    300: Color(0xFF484A4D),
    400: Color(0xFF313437),
    500: Color(_darkPrimaryValue),
    600: Color(0xFF171A1E),
    700: Color(0xFF15171A),
    800: Color(0xFF121417),
    900: Color(0xFF101114),
  },
);
const Color darkSecondary = Color(0xFF343741);
const Color lighterPrimary = Color(0xffe0e0e0);
const Color lighterSecondary = Color(0xfffafafa);