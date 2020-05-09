import 'package:covid19info/colors.dart';
import 'package:covid19info/fetchdata.dart';
import 'package:covid19info/main.dart';
import 'package:flutter/widgets.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:flutter_icons/flutter_icons.dart' as icons;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

AsyncSnapshot snapshot;
AsyncSnapshot snapshot2;
String MainUIState;
PageController _controller = PageController(
  initialPage: 0,
);

class MainUI extends StatefulWidget {
  @override
  _MainUIState createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStateData(homeScrState),
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
  @override
  void initState() {
    MainUIState = 'India';
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(snapshot.data[2][0].toString());
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
                    MainUIState,
                    style: TextStyle(
                        color: setColor(color: 'primary'),
                        fontSize: 80,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45.0, right: 45.0),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              // width: 310,
                              // height: 310,
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                color: setColor(color: 'secondary', alpha: 60),
                                child: homeScrInfo(),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Ink(
                                width: 45,
                                height: 45,
                                decoration: ShapeDecoration(
                                  color: setColor(color: 'primary'),
                                  shape: CircleBorder(),
                                ),
                                child: IconButton(
                                  icon: (darkMode == true)
                                      ? Icon(icons.Feather.sun)
                                      : Icon(icons.Feather.moon),
                                  color: setColor(color: 'third'),
                                  iconSize: 25,
                                  onPressed: () {
                                    setState(
                                      () {
                                        darkMode =
                                            (darkMode == true) ? false : true;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
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
                    alpha: 50,
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

  Widget homeScrInfo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: PageView(
        physics: new NeverScrollableScrollPhysics(),
        controller: _controller,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Stack(
            children: <Widget>[
              GridView.count(
                primary: false,
                crossAxisCount: 2,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 0,
                    color: Colors.blueAccent.withAlpha(40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 115,
                        height: 115,
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Active',
                              style: TextStyle(
                                  color: Colors.blueAccent.withAlpha(200),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              snapshot.data[1]['active'].toString(),
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 0,
                    color: Colors.blueGrey.withAlpha(40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 115,
                        height: 115,
                        child: Center(
                          child: ListTile(
                            isThreeLine: true,
                            title: Text(
                              'Deaths',
                              style: TextStyle(
                                  color: Colors.blueGrey.withAlpha(200),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: snapshot.data[1]['deaths'].toString(),
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data[1]['deltadeaths'] == 0
                                        ? ''
                                        : '\n+' +
                                            snapshot.data[1]['deltadeaths'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.blueGrey.withAlpha(200)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 0,
                    color: Colors.pink.withAlpha(40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 115,
                        height: 115,
                        child: Center(
                          child: ListTile(
                            isThreeLine: true,
                            title: Text(
                              'Confirmed',
                              style: TextStyle(
                                  color: Colors.pink.withAlpha(200),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: snapshot.data[1]['confirmed'].toString(),
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data[1]['deltaconfirmed'] ==
                                            0
                                        ? ''
                                        : '\n+' +
                                            snapshot.data[1]['deltaconfirmed'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.pink.withAlpha(200)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 0,
                    color: Colors.green.withAlpha(40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 115,
                        height: 115,
                        child: Center(
                          child: ListTile(
                            isThreeLine: true,
                            title: Text(
                              'Recovered',
                              style: TextStyle(
                                  color: Colors.green.withAlpha(200),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: snapshot.data[1]['recovered'].toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data[1]['deltarecovered'] ==
                                            0
                                        ? ''
                                        : '\n+' +
                                            snapshot.data[1]['deltarecovered'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.green.withAlpha(200)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Ink(
                  width: 45,
                  height: 45,
                  decoration: const ShapeDecoration(
                    color: Colors.black12,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(icons.Feather.chevron_down),
                    color: setColor(color: 'primary'),
                    iconSize: 25,
                    onPressed: () {
                      setState(
                        () {
                          MainUIState = snapshot.data[2][0].toString();
                          _controller.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutSine,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              GridView.count(
                primary: false,
                crossAxisCount: 2,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 0,
                    color: Colors.blueAccent.withAlpha(40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 115,
                        height: 115,
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Active',
                              style: TextStyle(
                                  color: Colors.blueAccent.withAlpha(200),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              snapshot.data[2][1].toString(),
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 0,
                    color: Colors.blueGrey.withAlpha(40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 115,
                        height: 115,
                        child: Center(
                          child: ListTile(
                            isThreeLine: true,
                            title: Text(
                              'Deaths',
                              style: TextStyle(
                                  color: Colors.blueGrey.withAlpha(200),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: snapshot.data[2][2].toString(),
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data[2][3] == 0
                                        ? ''
                                        : '\n+' +
                                            snapshot.data[2][3].toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.blueGrey.withAlpha(200)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 0,
                    color: Colors.pink.withAlpha(40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 115,
                        height: 115,
                        child: Center(
                          child: ListTile(
                            isThreeLine: true,
                            title: Text(
                              'Confirmed',
                              style: TextStyle(
                                  color: Colors.pink.withAlpha(200),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: snapshot.data[2][4].toString(),
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data[2][5] == 0
                                        ? ''
                                        : '\n+' +
                                            snapshot.data[2][5].toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.pink.withAlpha(200)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 0,
                    color: Colors.green.withAlpha(40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 115,
                        height: 115,
                        child: Center(
                          child: ListTile(
                            isThreeLine: true,
                            title: Text(
                              'Recovered',
                              style: TextStyle(
                                  color: Colors.green.withAlpha(200),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: snapshot.data[2][6].toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data[2][7] == 0
                                        ? ''
                                        : '\n+' +
                                            snapshot.data[2][7].toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.green.withAlpha(200)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Ink(
                  width: 45,
                  height: 45,
                  decoration: const ShapeDecoration(
                    color: Colors.black12,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(icons.Feather.chevron_up),
                    color: setColor(color: 'primary'),
                    iconSize: 25,
                    onPressed: () {
                      setState(
                        () {
                          MainUIState = 'India';
                          _controller.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutSine,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget createTable() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 130,
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
        width: 130,
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
      child: FlatButton(
        child: Text(
          snapshot.data[0][index + 1]['state'].toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: setColor(color: 'primary'),
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              backgroundColor: setColor(color: 'third'),
              title: Text(
                snapshot.data[0][index + 1]['state'].toString(),
                style: TextStyle(color: setColor(color: 'primary')),
                textAlign: TextAlign.center,
              ),
              content: Container(
                height: 420,
                width: 300,
                child: FutureBuilder(
                  future: getDistData(
                      snapshot.data[0][index + 1]['state'].toString()),
                  builder: (context, AsyncSnapshot distSnapshot) {
                    if (distSnapshot.connectionState == ConnectionState.done) {
                      snapshot2 = distSnapshot;
                      return ListView.builder(
                        itemCount: distSnapshot.data.length,
                        itemBuilder: (BuildContext context, int index2) {
                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: setColor(
                              color: 'secondary',
                              alpha: 100,
                            ),
                            child: ListTile(
                              title: Text(distSnapshot.data[index2]["district"]
                                  .toString()),
                              subtitle: Text('Active: ' +
                                  distSnapshot.data[index2]["active"]
                                      .toString()),
                            ),
                          );
                        },
                      );
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
                ),
              ),
            );
          },
        ),
        onLongPress: () {
          setStoredPref(snapshot.data[0][index + 1]['state'].toString());
          setState(() {
            homeScrState = snapshot.data[0][index + 1]['state'].toString();
            runApp(
              new MaterialApp(
                home: new MainUI(),
              ),
            );
          });
        },
      ),
      width: 130,
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
