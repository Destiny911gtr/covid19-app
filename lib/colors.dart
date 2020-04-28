import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';

//Color customColor = Color(0xffad8067);
Color customColor = Color(0xff181A1B);

bool darkMode = true;
bool altDark = false;

Color primaryColor = colorConv(50);
Color secondaryColor = colorConv(65);
Color thirdColor = colorConv(80);

Color primaryDark = colorConv(10);
Color secondaryDark = colorConv(20);
Color thirdDark = colorConv(30);

Color primaryAltDark = colorConv(30);
Color thirdAltDark = colorConv(10);

Color setColor({@required String color, int alpha}) {
  Color retColor;
  if (color == 'primary' && alpha != null) {
    retColor = darkMode ? (altDark ? primaryAltDark.withAlpha(alpha) : primaryDark.withAlpha(alpha)) : primaryColor.withAlpha(alpha);
  } else if (color == 'secondary' && alpha != null) {
    retColor = darkMode ? secondaryDark.withAlpha(alpha) : secondaryColor.withAlpha(alpha);
  } else if (color == 'third' && alpha != null) {
    retColor = darkMode ? (altDark ? thirdAltDark.withAlpha(alpha) : thirdDark.withAlpha(alpha)) : thirdColor.withAlpha(alpha);
  } else if (color == 'primary') {
    retColor = darkMode ? (altDark ? primaryAltDark : primaryDark) : primaryColor;
  } else if (color == 'secondary') {
    retColor = darkMode ? secondaryDark : secondaryColor;
  } else if (color == 'third') {
    retColor = darkMode ? (altDark ? thirdAltDark : thirdDark) : thirdColor;
  }
  return retColor;
}

Color colorConv(double lightness) {
  HslColor hsl = HslColor.fromColor(customColor);
  double h = double.parse(hsl.toString().split("(")[1].split(",")[0]);
  double s = double.parse(hsl.toString().split(",")[1]);
  HslColor hslColor = HslColor.fromList(<num>[h, s, lightness]);
  Color retColor = hslColor.toColor();
  return retColor;
}