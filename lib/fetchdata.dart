import "package:http/http.dart" as http;
import 'main.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

final stateUrl = 'https://api.covid19india.org/data.json';
final distUrl = 'https://api.covid19india.org/v2/state_district_wise.json';

// ignore: missing_return
Future<List> getStateData(String state) async {
  getStoredPref();
  sleep(Duration(milliseconds: 250));
  var stateResponse;
  List tempStateMap = [];
  List returnData = [[], [], []];

  try {
    stateResponse = await http.get(
      Uri.encodeFull(stateUrl),
      headers: {'Accept': 'application/json'},
    );
  } catch (e) {
    //noNetSnackbar();
  }

  if (stateResponse != null) {
    if (stateResponse.statusCode == 200) {
      dynamic convertStateDataJson = json.decode(stateResponse.body);
      tempStateMap = convertStateDataJson['statewise'];
    }
  }

  if (homeScrState != null) {
    var lengthOf = tempStateMap.length;
    for (var i = 0; i < lengthOf; i++) {
      if (tempStateMap[i]["state"] == homeScrState) {
        returnData[2].add(tempStateMap[i]["state"].toString());
        returnData[2].add(tempStateMap[i]["active"].toString());
        returnData[2].add(tempStateMap[i]["deaths"].toString());
        returnData[2].add(tempStateMap[i]["deltadeaths"].toString());
        returnData[2].add(tempStateMap[i]["confirmed"].toString());
        returnData[2].add(tempStateMap[i]["deltaconfirmed"].toString());
        returnData[2].add(tempStateMap[i]["recovered"].toString());
        returnData[2].add(tempStateMap[i]["deltarecovered"].toString());
        break;
      }
    }
  }

  returnData[0] = tempStateMap;
  returnData[1] = tempStateMap[0];
  //dynamic dist = tempDistMap[0]["districtData"];

  return returnData;
}

Future<List> getDistData(String state) async {
  var distResponse;
  List tempDistMap = [];
  List returnData = [[], []];

  try {
    distResponse = await http.get(
      Uri.encodeFull(distUrl),
      headers: {'Accept': 'application/json'},
    );
  } catch (e) {
    //noNetSnackbar();
  }

  dynamic convertDistDataJson = json.decode(distResponse.body);
  try {
    tempDistMap = convertDistDataJson;
    //distNotAvail = false;
    //buttonData('district', true);
  } catch (e) {
    //   //noDistDataSnackbar();
  }

  int t;
  for (int i = 0; i < tempDistMap.length; i++) {
    if (tempDistMap[i]["state"] == state) {
      returnData = tempDistMap[i]["districtData"];
      t = i;
      break;
    }
  }

  returnData = tempDistMap[t]["districtData"];
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
