import 'package:covid19info/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';

Color primaryColor = colorConv(43);
Color secondaryColor = colorConv(80);
Color thirdColor = colorConv(65);

Color colorConv(int lightness) {
  HslColor norColor = HslColor.fromColor(customColor);
  String hslString = norColor.toString();
  List hslList = hslString.split("(");
  List hslList2 = hslList[1].split(", ");
  double h = double.parse(hslList2[0]);
  double s = double.parse(hslList2[1]);
  double l = double.parse(lightness.toString());
  List<num> hslVal = [h, s, l];
  HslColor hslColor = HslColor.fromList(hslVal);
  return hslColor.toColor();
}

colorConv2() {

  String strValues = RgbColor.fromColor(customColor).toString();
  List rgbVal = strValues.split("(")[1].split(", ");
  int R = int.parse(rgbVal[0]);
  int G = int.parse(rgbVal[1]);
  int B = int.parse(rgbVal[2]);

  Map<int, Color> color = {
    50: Color.fromRGBO(R, G, B, .1),
    100: Color.fromRGBO(R, G, B, .2),
    200: Color.fromRGBO(R, G, B, .3),
    300: Color.fromRGBO(R, G, B, .4),
    400: Color.fromRGBO(R, G, B, .5),
    500: Color.fromRGBO(R, G, B, .6),
    600: Color.fromRGBO(R, G, B, .7),
    700: Color.fromRGBO(R, G, B, .8),
    800: Color.fromRGBO(R, G, B, .9),
    900: Color.fromRGBO(R, G, B, 1),
  };

  fontColor =  MaterialColor(customColor.value, color);
}
