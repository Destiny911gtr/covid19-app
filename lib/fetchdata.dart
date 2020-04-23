import 'package:covid19info/colors.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:flutter_icons/flutter_icons.dart' as mdicons;
import 'statewise.dart';
import 'settings.dart';
import 'main.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// ignore: missing_return
Future<List<Map>> getData() async {
  //sleep(Duration(milliseconds: 250));

  dynamic name;
  var stateResponse;
  var distResponse;
  Map tempStateMap = {};
  Map tempDistMap = {};
  List<Map> returnData = [{}, {}];

  try {
    stateResponse = await http.get(
      Uri.encodeFull(stateUrl),
      headers: {'Accept': 'application/json'},
    );
    distResponse = await http.get(
      Uri.encodeFull(distUrl),
      headers: {'Accept': 'application/json'},
    );
  } catch (e) {
    noNetSnackbar();
  }

  if (stateResponse != null) {
    if (stateResponse.statusCode == 200) {
      dynamic convertStateDataJson = json.decode(stateResponse.body);
      stateName = convertStateDataJson['statewise'];
      var lengthOf = stateName.length;
      for (var i = 0; i < lengthOf; i++) {
        if (stateName[i]["state"] == state) {
          tempStateMap = stateName[i];
          break;
        }
      }
      if (tempStateMap["state"] != 'Total') {
        dynamic convertDataJson = json.decode(distResponse.body);
        try {
          name = convertDataJson[state]['districtData'];
          distAvail = true;
          buttonData('district', true);
        } catch (e) {
          noDistDataSnackbar();
        }
        tempDistMap = {};
        try {
          name.forEach(
            (k, v) {
              var j = v['confirmed'];
              tempDistMap[k] = j;
            },
          );
        } catch (e) {
          NullThrownError();
        }
      } else if (tempStateMap["state"] == 'Total') {
        noDistDataSnackbar();
        tempDistMap[0] = 'None';
      } else {
        tempDistMap[0] = 'None';
      }
    }
  }
  returnData[0] = tempStateMap;
  returnData[1] = tempDistMap;
  return returnData;
}

void noNetSnackbar() {
  netAvail = false;
  scaffolkey.currentState.showSnackBar(
    SnackBar(
      duration: Duration(seconds: 20),
      elevation: 0,
      backgroundColor: fontColor,
      content: Container(
        height: 20,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Icon(
                mdicons.MaterialCommunityIcons.network_strength_off_outline,
                size: 20,
                color: fontColor.shade50,
              ),
            ),
            Text(
              'Network unavailable',
              textAlign: TextAlign.start,
              style: TextStyle(color: fontColor.shade50),
            ),
          ],
        ),
      ),
      action: SnackBarAction(
        textColor: fontColor.shade100,
        label: 'Reload',
        onPressed: () {
          netAvail = true;
          reloadApp();
        },
      ),
    ),
  );
}

void noDistDataSnackbar() {
  distAvail = false;
  buttonData('district', false);
  scaffolkey.currentState.showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        height: 50,
        child: Card(
          elevation: 0,
          color: primaryColor,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Icon(
                  mdicons.MaterialIcons.info_outline,
                  size: 20,
                  color: secondaryColor,
                ),
              ),
              Text(
                'District data unavailable',
                textAlign: TextAlign.start,
                style: TextStyle(color: secondaryColor),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
