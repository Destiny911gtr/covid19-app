import 'package:covid19info/colors.dart';
import 'package:covid19info/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart' as mdicons;
import 'package:timeago/timeago.dart' as timeago;
import 'dart:async';
import 'districts.dart';
import 'fetchdata.dart';
import 'settings.dart';
import 'main.dart';
import 'colors.dart';

final GlobalKey<ScaffoldState> scaffolkey = GlobalKey<ScaffoldState>();
PageController pageController = PageController(initialPage: 0);

String state = "Total";
String reftimeData;
bool netAvail = true;
bool distAvail = true;
double _height = 0;
double _sButtonWidth = 116;
double _sButtonHeight = 37;
double _dButtonWidth = 116;
double _dButtonHeight = 37;
bool refreshfader = false;
String refreshtime = 'COVID-19 Infection status';
dynamic stateName;
Map distMap = {};

// isOpaque() {
//   _opval = _opval == 0.0 ? 1.0 : 0.0;
// }

buttonData(String button, bool show) {
  show
      ? {
          if (button == 'settings')
            {
              _sButtonHeight = 37,
              _sButtonWidth = 116,
            }
          else
            {
              _dButtonHeight = 37,
              _dButtonWidth = 116,
            }
        }
      : {
          if (button == 'settings')
            {
              _sButtonHeight = 0,
              _sButtonWidth = 0,
            }
          else if (button == 'district')
            {
              _dButtonHeight = 0,
              _dButtonWidth = 0,
            }
        };
}

final stateUrl = 'https://api.covid19india.org/data.json';
final distUrl = 'https://api.covid19india.org/state_district_wise.json';

class StateWise extends StatefulWidget {
  @override
  StateWiseState createState() => StateWiseState();
}

class StateWiseState extends State<StateWise> {
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getStoredPrefs();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        afterBuild();
      },
    );
  }

  initStateData(String state) {
    buttonData('settings', true);
    _height = 0;
    setStoredPrefs(null, state);
    // stateMap = {
    //   "active": "Loading",
    //   "confirmed": "Loading",
    //   "deaths": "Loading",
    //   "deltaconfirmed": "Loading",
    //   "deltadeaths": "Loading",
    //   "deltarecovered": "Loading",
    //   "lastupdatedtime": "Loading",
    //   "recovered": "Loading",
    //   "state": state,
    // };
    refreshtime = 'Loading data, please wait...';
    //getData();
    buttonData('settings', true);
  }

  @override
  void dispose() {
    pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext stateContext) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light));
    return new Scaffold(
      key: scaffolkey,
      backgroundColor: secondaryColor,
      body: new SafeArea(
        child: FutureBuilder(
          future: getData(),
          builder: (stateContext, AsyncSnapshot snapshot) {
            primaryColor = colorConv(43);
            secondaryColor = colorConv(80);
            thirdColor = colorConv(65);
            reftimeData = snapshot.data[0]['lastupdatedtime'];
            distMap = snapshot.data[1];
            print(snapshot.data[1]);
            if (/*snapshot.connectionState == ConnectionState.done &&*/
                snapshot.data != null) {
              return PageView(
                physics: distAvail
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ListView(
                    controller: _scrollController,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: ListTile(
                              title: new Text(
                                (state == "Total")
                                    ? "India"
                                    : snapshot.data[0]['state'],
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w900,
                                  color: primaryColor,
                                ),
                              ),
                              subtitle: Container(
                                height: 35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    AnimatedCrossFade(
                                      firstChild: Text(
                                        'COVID-19 infection status',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      secondChild: Text(
                                        refreshtime,
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      crossFadeState: refreshfader
                                          ? CrossFadeState.showSecond
                                          : CrossFadeState.showFirst,
                                      firstCurve: Curves.easeOut,
                                      secondCurve: Curves.easeIn,
                                      sizeCurve: Curves.ease,
                                      duration: Duration(milliseconds: 250),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 8.0,
                                    right: 4.0,
                                  ),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: primaryColor,
                                    child: ListTile(
                                      leading: Icon(
                                        mdicons.MaterialCommunityIcons
                                            .account_multiple_outline,
                                        size: 40,
                                        color: secondaryColor,
                                      ),
                                      title: Text(
                                        'Total',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: secondaryColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        snapshot.data[0]['confirmed'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: thirdColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, top: 8.0, left: 4.0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: primaryColor,
                                    child: ListTile(
                                      leading: Icon(
                                        mdicons.MaterialCommunityIcons
                                            .account_plus_outline,
                                        size: 40,
                                        color: secondaryColor,
                                      ),
                                      title: Text(
                                        'Active',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: secondaryColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        snapshot.data[0]['active'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: thirdColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8.0, right: 4.0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: primaryColor,
                                    child: ListTile(
                                      leading: Icon(
                                        mdicons.MaterialCommunityIcons
                                            .account_remove_outline,
                                        size: 40,
                                        color: secondaryColor,
                                      ),
                                      title: Text(
                                        'Deaths',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: secondaryColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        snapshot.data[0]['deaths'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: thirdColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, top: 8.0, left: 4.0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: primaryColor,
                                    child: ListTile(
                                      leading: Icon(
                                        mdicons.MaterialCommunityIcons
                                            .account_heart_outline,
                                        size: 40,
                                        color: secondaryColor,
                                      ),
                                      title: Text(
                                        'Recovered',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: secondaryColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        snapshot.data[0]['recovered'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: thirdColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: ListTile(
                                title: Text(
                                  'New Cases',
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w800,
                                      color: primaryColor),
                                ),
                                subtitle: Text(
                                  'Refreshed ~ every 24 hrs ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, top: 8.0, left: 4.0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: primaryColor,
                                    child: ListTile(
                                      leading: Icon(
                                        mdicons.MaterialCommunityIcons
                                            .account_multiple_plus_outline,
                                        size: 40,
                                        color: secondaryColor,
                                      ),
                                      title: Text(
                                        'Confirmed',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: secondaryColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        snapshot.data[0]['deltaconfirmed'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: thirdColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8.0, right: 4.0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: primaryColor,
                                    child: ListTile(
                                      leading: Icon(
                                        mdicons.MaterialCommunityIcons
                                            .account_remove_outline,
                                        size: 40,
                                        color: secondaryColor,
                                      ),
                                      title: Text(
                                        'Deaths',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: secondaryColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        snapshot.data[0]['deltadeaths'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: thirdColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, top: 8.0, left: 4.0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: primaryColor,
                                    child: ListTile(
                                      leading: Icon(
                                        mdicons.MaterialCommunityIcons
                                            .account_heart_outline,
                                        size: 40,
                                        color: secondaryColor,
                                      ),
                                      title: Text(
                                        'Recovered',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: secondaryColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        snapshot.data[0]['deltarecovered'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: thirdColor,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, right: 4.0),
                                child: Center(
                                  child: AnimatedContainer(
                                    height: _dButtonHeight,
                                    width: _dButtonWidth,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                    child: OutlineButton.icon(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      splashColor: primaryColor,
                                      highlightedBorderColor: primaryColor,
                                      label: Text(
                                        'Districts',
                                        style: TextStyle(
                                            color: primaryColor, fontSize: 17),
                                      ),
                                      icon: Icon(
                                        mdicons.Ionicons.md_globe,
                                        size: 17,
                                        color: primaryColor,
                                      ),
                                      color: primaryColor,
                                      onPressed: () {
                                        if (pageController.hasClients) {
                                          pageController.animateToPage(
                                            1,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.fastOutSlowIn,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 4.0),
                                child: Center(
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                    width: _sButtonWidth,
                                    height: _sButtonHeight,
                                    child: OutlineButton.icon(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        splashColor: primaryColor,
                                        highlightedBorderColor: primaryColor,
                                        label: Text(
                                          "Settings",
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 17),
                                        ),
                                        icon: Icon(
                                          mdicons
                                              .MaterialCommunityIcons.settings,
                                          size: 17,
                                          color: primaryColor,
                                        ),
                                        color: primaryColor,
                                        onPressed: () {
                                          setState(() {
                                            _height = 290;
                                            buttonData('settings', false);
                                            _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              curve: Curves.ease,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            );
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, bottom: 4.0),
                            child: AnimatedContainer(
                              duration: (Duration(seconds: 1)),
                              constraints:
                                  BoxConstraints(minWidth: 500, maxWidth: 500),
                              height: _height,
                              curve: Curves.ease,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: primaryColor,
                                  elevation: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            'Settings',
                                            style: TextStyle(
                                                color: secondaryColor,
                                                fontSize: 30),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Select Region: ',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: secondaryColor),
                                                  ),
                                                  OutlineButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    splashColor: primaryColor,
                                                    highlightedBorderColor:
                                                        secondaryColor,
                                                    child: Text(
                                                      state,
                                                      style: TextStyle(
                                                          color: secondaryColor,
                                                          fontSize: 15),
                                                    ),
                                                    onPressed: () =>
                                                        showReportDialog(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.0,
                                                left: 8.0,
                                                right: 8.0,
                                                bottom: 8.0),
                                            child: Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Choose Theme: ',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: secondaryColor),
                                                  ),
                                                  OutlineButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    splashColor: primaryColor,
                                                    highlightedBorderColor:
                                                        secondaryColor,
                                                    child: Icon(
                                                      mdicons
                                                          .MaterialCommunityIcons
                                                          .palette_outline,
                                                      color: secondaryColor,
                                                    ),
                                                    onPressed: () =>
                                                        showThemePicker(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          OutlineButton.icon(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            onPressed: () => showAboutInfo(),
                                            icon: Icon(
                                              mdicons.MaterialCommunityIcons
                                                  .information_outline,
                                              size: 17,
                                              color: secondaryColor,
                                            ),
                                            label: Text(
                                              'About',
                                              style: TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          OutlineButton.icon(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            splashColor: primaryColor,
                                            highlightedBorderColor:
                                                secondaryColor,
                                            label: Text(
                                              "Close",
                                              style: TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 17),
                                            ),
                                            icon: Icon(
                                              mdicons.MaterialIcons.close,
                                              size: 17,
                                              color: secondaryColor,
                                            ),
                                            color: secondaryColor,
                                            onPressed: () {
                                              setState(() {
                                                _height = 0;
                                                buttonData('settings', true);
                                                _scrollController.animateTo(
                                                  0.0,
                                                  curve: Curves.ease,
                                                  duration: const Duration(
                                                    seconds: 1,
                                                  ),
                                                );
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  DistWise(),
                ],
              );
            } else if (snapshot.hasError) {
              Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('Error Loading'),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  showReportDialog() {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: secondaryColor,
            title: Text(
              "Select Your State",
              style: TextStyle(color: primaryColor),
            ),
            content: Container(
              height: 350,
              width: 300,
              child: SingleChildScrollView(
                child: MultiSelectChip(
                  items,
                  onSelectionChanged: (selectedList) {
                    setState(() {
                      state = selectedList;
                      reloadApp();
                    });
                  },
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  textColor: primaryColor,
                  highlightColor: colorConv(50),
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  textColor: primaryColor,
                  highlightColor: colorConv(50),
                  child: Text("Select"),
                  onPressed: () {
                    setState(() {
                      _height = 0;
                      initStateData(state);
                    });
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  showAboutInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: secondaryColor,
          title: Text(
            "Created by",
            style: TextStyle(color: primaryColor),
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: 420,
            width: 300,
            child: appInfoDialog(context),
          ),
        );
      },
    );
  }

  showThemePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: secondaryColor,
          title: Text(
            "Choose a colour",
            style: TextStyle(color: primaryColor),
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: 370,
            width: 300,
            child: ThemePicker(),
          ),
        );
      },
    );
  }

  void loadData() {
    //await new Future.delayed(const Duration(seconds: 1));
    if (netAvail == true) {
      setState(
        () {
          refreshtime = 'Refreshed ' + refreshTime();
        },
      );
    }
  }

  Future<void> afterBuild() async {
    await new Future.delayed(const Duration(seconds: 1));
    if (netAvail == true) {
      try {
        setState(
          () {},
        );
      } catch (e) {
        NullThrownError();
      }
    }
  }

  String refreshTime() {
    if (netAvail == true) {
      try {
        String date = reftimeData.split(" ")[0];
        String day = date.split("/")[0];
        String month = date.split("/")[1];
        String year = date.split("/")[2];
        dynamic lref =
            year + "-" + month + "-" + day + " " + reftimeData.split(" ")[1];
        lref = DateTime.parse(lref);
        refreshfader = true;
        return timeago.format(lref);
      } catch (e) {
        getData();
        this.initStateData(state);
      } // TODO: This crashes app, better handle it.
    }
  }
}
