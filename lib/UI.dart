import 'package:covid19info/colors.dart';
import 'package:covid19info/fetchdata.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

AsyncSnapshot snapshot;

class MainUI extends StatefulWidget {
  @override
  _MainUIState createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, AsyncSnapshot dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.done) {
          snapshot = dataSnapshot;
          return IndiaData();
        } else {
          return Scaffold(
            backgroundColor: setColor(color: 'third'),
            body: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  setColor(color: 'primary'),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class IndiaData extends StatefulWidget {
  @override
  _IndiaDataState createState() => _IndiaDataState();
}

class _IndiaDataState extends State<IndiaData> {
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: setColor(color: 'third'),
      body: SafeArea(
        child: PageView(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'India',
                    style: TextStyle(
                        color: setColor(color: 'primary'),
                        fontSize: 80,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                  Center(
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: setColor(color: 'primary'),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 170,
                                        height: 70,
                                        child: ListTile(
                                          subtitle: Text(
                                            'Active',
                                            style: TextStyle(
                                                color: setColor(color: 'third'),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                            textAlign: TextAlign.center,
                                          ),
                                          title: Text(
                                            snapshot.data[2]['active']
                                                .toString(),
                                            style: TextStyle(
                                                color: setColor(
                                                    color: 'third', alpha: 150),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: setColor(color: 'primary'),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 170,
                                        height: 70,
                                        child: ListTile(
                                          subtitle: Text(
                                            'Deaths',
                                            style: TextStyle(
                                                color: setColor(color: 'third'),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                            textAlign: TextAlign.center,
                                          ),
                                          title: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: snapshot.data[2]['deaths']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: setColor(
                                                      color: 'third',
                                                      alpha: 150),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: snapshot.data[2]
                                                              ['deltadeaths'] ==
                                                          0
                                                      ? ''
                                                      : ' (+' +
                                                          snapshot.data[2]
                                                              ['deltadeaths'] +
                                                          ')',
                                                  style: TextStyle(
                                                    color: Color.alphaBlend(
                                                      Colors.red.shade200,
                                                      setColor(
                                                          color: 'primary'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: setColor(color: 'primary'),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 170,
                                        height: 70,
                                        child: ListTile(
                                          subtitle: Text(
                                            'Confirmed',
                                            style: TextStyle(
                                                color: setColor(color: 'third'),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                            textAlign: TextAlign.center,
                                          ),
                                          title: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: snapshot.data[2]
                                                      ['confirmed']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: setColor(
                                                    color: 'third', alpha: 150),
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: snapshot.data[2][
                                                              'deltaconfirmed'] ==
                                                          0
                                                      ? ''
                                                      : ' (+' +
                                                          snapshot.data[2][
                                                              'deltaconfirmed'] +
                                                          ')',
                                                  style: TextStyle(
                                                    color: Color.alphaBlend(
                                                      Colors.red.shade200,
                                                      setColor(
                                                          color: 'primary'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: setColor(color: 'primary'),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 170,
                                        height: 70,
                                        child: ListTile(
                                          subtitle: Text(
                                            'Recovered',
                                            style: TextStyle(
                                                color: setColor(color: 'third'),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                            textAlign: TextAlign.center,
                                          ),
                                          title: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: snapshot.data[2]
                                                      ['recovered']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: setColor(
                                                      color: 'third',
                                                      alpha: 150),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: snapshot.data[2][
                                                              'deltarecovered'] ==
                                                          0
                                                      ? ''
                                                      : ' (+' +
                                                          snapshot.data[2][
                                                              'deltarecovered'] +
                                                          ')',
                                                  style: TextStyle(
                                                    color: Color.alphaBlend(
                                                      Colors.green.shade200,
                                                      setColor(
                                                          color: 'primary'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 200,
                                child: SwitchListTile.adaptive(
                                  title: Text(
                                    'Dark Mode',
                                    style: TextStyle(
                                        color: setColor(color: 'primary'),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                    textAlign: TextAlign.center,
                                  ),
                                  value: darkMode,
                                  onChanged: (bool value) {
                                    setState(
                                      () {
                                        darkMode = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 0,
                  color: setColor(
                    color: 'secondary',
                    alpha: 100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: <Widget>[
                        createTable(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createTable() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 260,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: snapshot.data[0].length - 1,
        rowSeparatorWidget: const Divider(
          color: Colors.black12,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Colors.transparent,
        rightHandSideColBackgroundColor: Colors.transparent,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      Container(
        child: Text(
          'States',
          style: TextStyle(
              color: setColor(color: 'primary'),
              fontSize: 15,
              fontWeight: FontWeight.w800),
        ),
        width: 100,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
      Container(
        child: Text(
          'Confirmed',
          style: TextStyle(
              color: setColor(color: 'primary'),
              fontSize: 15,
              fontWeight: FontWeight.w800),
        ),
        width: 80,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
      Container(
        child: Text(
          'Deaths',
          style: TextStyle(
              color: setColor(color: 'primary'),
              fontSize: 15,
              fontWeight: FontWeight.w800),
        ),
        width: 80,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
      Container(
        child: Text(
          'Recovered',
          style: TextStyle(
              color: setColor(color: 'primary'),
              fontSize: 15,
              fontWeight: FontWeight.w800),
        ),
        width: 80,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
    ];
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(
        snapshot.data[0][index + 1]['state'].toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: setColor(color: 'primary'),
            fontSize: 15,
            fontWeight: FontWeight.w500),
      ),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Text(
            snapshot.data[0][index + 1]['confirmed'].toString(),
            style: TextStyle(
                color: setColor(color: 'primary'),
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          width: 80,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(
            snapshot.data[0][index + 1]['deaths'].toString(),
            style: TextStyle(
                color: setColor(color: 'primary'),
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          width: 80,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(
            snapshot.data[0][index + 1]['recovered'].toString(),
            style: TextStyle(
                color: setColor(color: 'primary'),
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          width: 80,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
