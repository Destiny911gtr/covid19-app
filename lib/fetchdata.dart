import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:flutter_icons/flutter_icons.dart' as mdicons;
import 'statewise.dart';
import 'main.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// ignore: missing_return
Future<List> getData() async {
  sleep(Duration(milliseconds: 250));
  var stateResponse;
  var distResponse;
  List tempStateMap = [];
  Map tempDistMap = {};
  List returnData = [[], [], []];

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
    //noNetSnackbar();
  }

  if (stateResponse != null) {
    if (stateResponse.statusCode == 200) {
      dynamic convertStateDataJson = json.decode(stateResponse.body);
      tempStateMap = convertStateDataJson['statewise'];
      if (stateMap["state"] != 'Total') {
        dynamic convertDistDataJson = json.decode(distResponse.body);
        //try {
          tempDistMap = convertDistDataJson;
          distNotAvail = false;
          buttonData('district', true);
        // } catch (e) {
        //   //noDistDataSnackbar();
        // }
      } else if (stateMap["state"] == 'Total') {
        //noDistDataSnackbar();
        tempDistMap[0] = 'None';
      } else {
        tempDistMap[0] = 'None';
      }
    }
  }
  returnData[0] = tempStateMap;
  returnData[1] = [tempDistMap];
  returnData[2] = tempStateMap[0];
  //print(fontColor.toString());
  return returnData;
}

// void noNetSnackbar() {
//   netAvail = false;
//   scaffolkey.currentState.showSnackBar(
//     SnackBar(
//       duration: Duration(seconds: 20),
//       elevation: 0,
//       backgroundColor: fontColor,
//       content: Container(
//         height: 20,
//         child: Row(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//               child: Icon(
//                 mdicons.MaterialCommunityIcons.network_strength_off_outline,
//                 size: 20,
//                 color: fontColor.shade50,
//               ),
//             ),
//             Text(
//               'Network unavailable',
//               textAlign: TextAlign.start,
//               style: TextStyle(color: fontColor.shade50),
//             ),
//           ],
//         ),
//       ),
//       action: SnackBarAction(
//         textColor: fontColor.shade100,
//         label: 'Reload',
//         onPressed: () {
//           netAvail = true;
//           // TODO: Some code to undo the change.
//         },
//       ),
//     ),
//   );
// }

// void noDistDataSnackbar() {
//   distNotAvail = true;
//   buttonData('district', false);
//   scaffolkey.currentState.showSnackBar(
//     SnackBar(
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       content: Container(
//         height: 50,
//         child: Card(
//           elevation: 0,
//           color: fontColor,
//           child: Row(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                 child: Icon(
//                   mdicons.MaterialIcons.info_outline,
//                   size: 20,
//                   color: fontColor.shade50,
//                 ),
//               ),
//               Text(
//                 'District data unavailable',
//                 textAlign: TextAlign.start,
//                 style: TextStyle(color: fontColor.shade50),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
