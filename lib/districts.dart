import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'statewise.dart';
import 'main.dart';

class DistWise extends StatefulWidget {
  @override
  _DistWiseState createState() => _DistWiseState();
}

class _DistWiseState extends State<DistWise> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext distContext) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: fontColor.shade50,
        systemNavigationBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: fontColor.shade50,
      appBar: AppBar(
        iconTheme: IconThemeData(color: fontColor.shade50),
        title: Text(
          'Regional Confirmation Data',
          style: TextStyle(color: fontColor.shade50),
        ),
        backgroundColor: fontColor,
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Card(
                  margin: EdgeInsets.all(0),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  color: fontColor.shade200,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      'These numbers are cumulated totals',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: fontColor,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, bottom: 0.0, top: 30.0),
            child: GridView.count(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 2.5,
              crossAxisCount: 2,
              children: List.generate(
                distMap == null ? 0 : distMap.length,
                (index) {
                  String key = distMap.keys.elementAt(index);
                  return Center(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: fontColor,
                      child: ListTile(
                        title: Container(
                          width: 30,
                          height: 20,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.contain,
                            child: Text(
                              '$key',
                              style: TextStyle(
                                  color: fontColor.shade50, fontSize: 20),
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '${distMap[key]}',
                          style: TextStyle(
                              color: fontColor.shade100, fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
