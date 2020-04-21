library page_transition;

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
import 'main.dart';

String state = "Kerala";
final GlobalKey<ScaffoldState> scaffolkey = GlobalKey<ScaffoldState>();
bool netAvail = true;
bool distNotAvail = false;
int stateId;
double _height = 0;
double _sButtonWidth = 116;
double _sButtonHeight = 37;
double _dButtonWidth = 116;
double _dButtonHeight = 37;
double _opval = 1.0;
bool refreshfader = false;
String refreshtime = 'COVID-19 Infection status';
dynamic stateName;
dynamic name;
ScrollController _scrollController = new ScrollController();
PageController _pageController = PageController(initialPage: 0);
Map distMap = {};
Map stateMap = {
  "active": "Loading",
  "confirmed": "Loading",
  "deaths": "Loading",
  "deltaconfirmed": "Loading",
  "deltadeaths": "Loading",
  "deltarecovered": "Loading",
  "lastupdatedtime": "Loading",
  "recovered": "Loading",
  "state": "Loading",
};

isOpaque() {
  _opval = _opval == 0.0 ? 1.0 : 0.0;
}

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
  _StateWiseState createState() => _StateWiseState();
}

class _StateWiseState extends State<StateWise> {
  @override
  void initState() {
    super.initState();
    getStatePref();
    getData();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        afterBuild();
      },
    );
  }

  initStateData(String state) {
    buttonData('settings', true);
    _height = 0;
    setStatePref(state);
    stateMap = {
      "active": "Loading",
      "confirmed": "Loading",
      "deaths": "Loading",
      "deltaconfirmed": "Loading",
      "deltadeaths": "Loading",
      "deltarecovered": "Loading",
      "lastupdatedtime": "Loading",
      "recovered": "Loading",
      "state": state,
    };
    refreshtime = 'Loading data, please wait...';
    getData();
    loadingData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext stateContext) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: fontColor.shade50,
        systemNavigationBarIconBrightness: Brightness.light));
    return Scaffold(
        key: scaffolkey,
        backgroundColor: fontColor.shade50,
        body: PageView(
          controller: _pageController,
          physics: distNotAvail
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            new SafeArea(
              child: ListView(
                controller: _scrollController,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: ListTile(
                          title: new Text(
                            (state == "Total") ? "India" : stateMap['state'],
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.w900,
                              color: fontColor,
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
                                        color: fontColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  secondChild: Text(
                                    refreshtime,
                                    style: TextStyle(
                                        color: fontColor,
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
                                color: fontColor,
                                child: ListTile(
                                  leading: Icon(
                                    mdicons.MaterialCommunityIcons
                                        .account_multiple_outline,
                                    size: 40,
                                    color: fontColor.shade50,
                                  ),
                                  title: Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: fontColor.shade50,
                                    ),
                                  ),
                                  subtitle: Text(
                                    stateMap['confirmed'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: fontColor.shade100,
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
                                color: fontColor,
                                child: ListTile(
                                  leading: Icon(
                                    mdicons.MaterialCommunityIcons
                                        .account_plus_outline,
                                    size: 40,
                                    color: fontColor.shade50,
                                  ),
                                  title: Text(
                                    'Active',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: fontColor.shade50,
                                    ),
                                  ),
                                  subtitle: Text(
                                    stateMap['active'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: fontColor.shade100,
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
                                color: fontColor,
                                child: ListTile(
                                  leading: Icon(
                                    mdicons.MaterialCommunityIcons
                                        .account_remove_outline,
                                    size: 40,
                                    color: fontColor.shade50,
                                  ),
                                  title: Text(
                                    'Deaths',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: fontColor.shade50,
                                    ),
                                  ),
                                  subtitle: Text(
                                    stateMap['deaths'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: fontColor.shade100,
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
                                color: fontColor,
                                child: ListTile(
                                  leading: Icon(
                                    mdicons.MaterialCommunityIcons
                                        .account_heart_outline,
                                    size: 40,
                                    color: fontColor.shade50,
                                  ),
                                  title: Text(
                                    'Recovered',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: fontColor.shade50,
                                    ),
                                  ),
                                  subtitle: Text(
                                    stateMap['recovered'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: fontColor.shade100,
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
                                  color: fontColor),
                            ),
                            subtitle: Text(
                              'Refreshed ~ every 24 hrs ',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: fontColor,
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
                                color: fontColor,
                                child: ListTile(
                                  leading: Icon(
                                    mdicons.MaterialCommunityIcons
                                        .account_multiple_plus_outline,
                                    size: 40,
                                    color: fontColor.shade50,
                                  ),
                                  title: Text(
                                    'Confirmed',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: fontColor.shade50,
                                    ),
                                  ),
                                  subtitle: Text(
                                    stateMap['deltaconfirmed'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: fontColor.shade100,
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
                                color: fontColor,
                                child: ListTile(
                                  leading: Icon(
                                    mdicons.MaterialCommunityIcons
                                        .account_remove_outline,
                                    size: 40,
                                    color: fontColor.shade50,
                                  ),
                                  title: Text(
                                    'Deaths',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: fontColor.shade50,
                                    ),
                                  ),
                                  subtitle: Text(
                                    stateMap['deltadeaths'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: fontColor.shade100,
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
                                color: fontColor,
                                child: ListTile(
                                  leading: Icon(
                                    mdicons.MaterialCommunityIcons
                                        .account_heart_outline,
                                    size: 40,
                                    color: fontColor.shade50,
                                  ),
                                  title: Text(
                                    'Recovered',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: fontColor.shade50,
                                    ),
                                  ),
                                  subtitle: Text(
                                    stateMap['deltarecovered'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: fontColor.shade100,
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
                            padding:
                                const EdgeInsets.only(top: 20.0, right: 4.0),
                            child: Center(
                              child: AnimatedContainer(
                                height: _dButtonHeight,
                                width: _dButtonWidth,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                                child: OutlineButton.icon(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  splashColor: fontColor.shade200,
                                  highlightedBorderColor: fontColor,
                                  label: Text(
                                    'Districts',
                                    style: TextStyle(
                                        color: fontColor, fontSize: 17),
                                  ),
                                  icon: Icon(
                                    mdicons.Ionicons.md_globe,
                                    size: 17,
                                    color: fontColor,
                                  ),
                                  color: fontColor,
                                  onPressed: () {
                                    if (_pageController.hasClients) {
                                      _pageController.animateToPage(
                                        1,
                                        duration:
                                            const Duration(milliseconds: 500),
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
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    splashColor: fontColor.shade200,
                                    highlightedBorderColor: fontColor,
                                    label: Text(
                                      "Settings",
                                      style: TextStyle(
                                          color: fontColor, fontSize: 17),
                                    ),
                                    icon: Icon(
                                      mdicons.MaterialCommunityIcons.settings,
                                      size: 17,
                                      color: fontColor,
                                    ),
                                    color: fontColor,
                                    onPressed: () {
                                      setState(() {
                                        _height = 235;
                                        buttonData('settings', false);
                                        _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          curve: Curves.ease,
                                          duration:
                                              const Duration(milliseconds: 300),
                                        );
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
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
                              color: fontColor,
                              elevation: 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        'Settings',
                                        style: TextStyle(
                                            color: fontColor.shade50,
                                            fontSize: 30),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                    color: fontColor.shade50),
                                              ),
                                              OutlineButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                splashColor: fontColor.shade200,
                                                highlightedBorderColor:
                                                    fontColor.shade50,
                                                child: Text(
                                                  state,
                                                  style: TextStyle(
                                                      color: fontColor.shade50,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          color: fontColor.shade50,
                                        ),
                                        label: Text(
                                          'About',
                                          style: TextStyle(
                                              color: fontColor.shade50,
                                              fontSize: 17),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      OutlineButton.icon(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        splashColor: fontColor.shade200,
                                        highlightedBorderColor:
                                            fontColor.shade50,
                                        label: Text(
                                          "Close",
                                          style: TextStyle(
                                              color: fontColor.shade50,
                                              fontSize: 17),
                                        ),
                                        icon: Icon(
                                          mdicons.MaterialIcons.close,
                                          size: 17,
                                          color: fontColor.shade50,
                                        ),
                                        color: fontColor.shade50,
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
            ),
            new DistWise(),
          ],
        ));
  }

  showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: fontColor.shade50,
            title: Text(
              "Select Your State",
              style: TextStyle(color: fontColor),
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
                  textColor: fontColor,
                  highlightColor: fontColor.shade200,
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  textColor: fontColor,
                  highlightColor: fontColor.shade200,
                  child: Text("Select"),
                  onPressed: () {
                    initStateData(state);
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
            backgroundColor: fontColor.shade50,
            title: Text(
              "Created by",
              style: TextStyle(color: fontColor),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 420,
              width: 300,
              child: appInfoDialog(context),
            ),
          );
        });
  }

  Future<void> loadingData() async {
    await new Future.delayed(const Duration(seconds: 1));
    if (netAvail == true) {
      buttonData('settings', true);
      setState(() {
        refreshtime = 'Refreshed ' + refreshTime();
      });
    }
  }

  Future<void> afterBuild() async {
    await new Future.delayed(const Duration(seconds: 2));
    if (netAvail == true) {
      setState(() {
        refreshtime = 'Refreshed ' + refreshTime();
      });
    }
  }

  String refreshTime() {
    if (netAvail == true) {
      try {
        String reft = stateMap['lastupdatedtime'].toString();
        String date = reft.split(" ")[0];
        String day = date.split("/")[0];
        String month = date.split("/")[1];
        String year = date.split("/")[2];
        dynamic lref =
            year + "-" + month + "-" + day + " " + reft.split(" ")[1];
        lref = DateTime.parse(lref);
        refreshfader = true;
        return timeago.format(lref);
      } catch (e) {
        getData();
        this.refreshTime();
      } // TODO: This crashes app, better handle it.
    }
  }
}
