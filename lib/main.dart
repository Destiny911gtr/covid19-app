import 'package:covid19info/UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart' as randc;
import 'package:shared_preferences/shared_preferences.dart';

String homeScrState = 'Total';

MaterialColor fontColor = randc.RandomColor().randomMaterialColor(
  colorSaturation: randc.ColorSaturation.lowSaturation,
  colorHue: randc.ColorHue.random,
);
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

void setStoredPref(String data) async {
  SharedPreferences prefState = await SharedPreferences.getInstance();
  prefState.setString('state', data);
}

void getStoredPref() async {
  SharedPreferences prefState = await SharedPreferences.getInstance();
  homeScrState = prefState.getString('state') == null ? 'Kerala' : prefState.getString('state');
}

void main() => runApp(
      new MaterialApp(
        home: new MainUI(),
      ),
    );
