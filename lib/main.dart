import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart' as randc;
import 'package:shared_preferences/shared_preferences.dart';
import 'statewise.dart';

void setStoredPrefs(int color, String state) async {
  SharedPreferences prefState = await SharedPreferences.getInstance();
  if (color == null) {
  prefState.setString('state', state);
  } else if (state == null) {
  prefState.setInt('color', color);
  }
}

void getStoredPrefs() async {
  SharedPreferences prefState = await SharedPreferences.getInstance();
  state = prefState.getString('state') == null
      ? 'Total'
      : prefState.getString('state');
  customColor = Color(prefState.getInt('color'));
}

dynamic fontColor = randc.RandomColor().randomMaterialColor(
  colorSaturation: randc.ColorSaturation.lowSaturation,
  colorHue: randc.ColorHue.random,
);

Color customColor = Color(0xff607d8b);

List<String> items = [
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
  'Andaman and Nicobar Islands',
  'Chandigarh',
  'Dadra and Nagar Haveli',
  'Daman and Diu',
  'Delhi',
  'Jammu and Kashmir',
  'Ladakh',
  'Lakshadweep',
  'Puducherry',
  'Total'
];

void main() => runApp(
      new MaterialApp(
        home: new StateWise(),
        ),
      );