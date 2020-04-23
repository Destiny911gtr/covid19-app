import 'package:covid19info/statewise.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_icons/flutter_icons.dart' as mdicons;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:covid19info/main.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'districts.dart';
import 'main.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(String) onSelectionChanged;
  MultiSelectChip(this.reportList, {this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  String selectedChoice = "";
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          backgroundColor: thirdColor,
          selectedColor: primaryColor,
          shadowColor: Colors.transparent,
          selectedShadowColor: Colors.transparent,
          label: Text(
            item,
            style: TextStyle(color: secondaryColor),
          ),
          selected: state == item,
          onSelected: (selected) {
            setState(() {
              state = item;
              //widget.onSelectionChanged(state);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 0.0,
      children: _buildChoiceList(),
    );
  }
}

Widget appInfoDialog(BuildContext context) {
  return Card(
    color: fontColor.shade50,
    elevation: 0,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/ded.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            'Dhanush Krishnan',
                            style: TextStyle(
                                color: fontColor.shade800, fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Center(
                          child: Ink(
                            width: 40,
                            height: 40,
                            decoration: const ShapeDecoration(
                              color: Color.fromARGB(50, 0, 136, 204),
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              splashColor: Color.fromARGB(255, 0, 136, 204),
                              icon: Icon(
                                mdicons.MaterialCommunityIcons.telegram,
                                color: Color.fromARGB(255, 0, 136, 204),
                              ),
                              onPressed: () =>
                                  _launchURL('http://t.me/Ded_Boi'),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Center(
                          child: Ink(
                            width: 40,
                            height: 40,
                            decoration: const ShapeDecoration(
                              color: Color.fromARGB(50, 58, 49, 51),
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(
                                mdicons.MaterialCommunityIcons.github_circle,
                                color: Color.fromARGB(255, 58, 49, 51),
                              ),
                              onPressed: () => _launchURL(
                                  'https://github.com/Destiny911gtr'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/marv.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            'Marvin Clement',
                            style: TextStyle(
                                color: fontColor.shade800, fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Center(
                          child: Ink(
                            width: 40,
                            height: 40,
                            decoration: const ShapeDecoration(
                              color: Color.fromARGB(50, 0, 136, 204),
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              splashColor: Color.fromARGB(255, 0, 136, 204),
                              icon: Icon(
                                mdicons.MaterialCommunityIcons.telegram,
                                color: Color.fromARGB(255, 0, 136, 204),
                              ),
                              onPressed: () =>
                                  _launchURL('http://t.me/Credance'),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Center(
                          child: Ink(
                            width: 40,
                            height: 40,
                            decoration: const ShapeDecoration(
                              color: Color.fromARGB(50, 58, 49, 51),
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(
                                mdicons.MaterialCommunityIcons.github_circle,
                                color: Color.fromARGB(255, 58, 49, 51),
                              ),
                              onPressed: () =>
                                  _launchURL('https://github.com/MA3V1N'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Icon By',
          style: TextStyle(color: fontColor, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Al Shifan S H',
              style: TextStyle(color: fontColor.shade800, fontSize: 17),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 10),
            Center(
              child: Ink(
                width: 40,
                height: 40,
                decoration: const ShapeDecoration(
                  color: Color.fromARGB(50, 0, 136, 204),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  splashColor: Color.fromARGB(255, 0, 136, 204),
                  icon: Icon(
                    mdicons.MaterialCommunityIcons.telegram,
                    color: Color.fromARGB(255, 0, 136, 204),
                  ),
                  onPressed: () => _launchURL('https://t.me/alshifan01'),
                ),
              ),
            ),
            SizedBox(width: 10),
            Center(
              child: Ink(
                width: 40,
                height: 40,
                decoration: const ShapeDecoration(
                  color: Color.fromARGB(50, 23, 105, 255),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  splashColor: Color.fromARGB(255, 23, 105, 255),
                  icon: Icon(
                    mdicons.MaterialCommunityIcons.behance,
                    color: Color.fromARGB(255, 23, 105, 255),
                  ),
                  onPressed: () =>
                      _launchURL('https://www.behance.net/alshifan410591'),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 500,
          child: FlatButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            onPressed: () => _launchURL('https://github.com/covid19india'),
            icon: Center(
              child: Ink(
                width: 40,
                height: 40,
                decoration: const ShapeDecoration(
                  color: Color.fromARGB(50, 58, 49, 51),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(
                    mdicons.MaterialCommunityIcons.github_circle,
                    color: Color.fromARGB(255, 58, 49, 51),
                  ),
                  onPressed: () =>
                      _launchURL('https://github.com/covid19india'),
                ),
              ),
            ),
            label: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Thanks to the team at \ncovid19india, for their \nawesome API',
                style: TextStyle(
                  color: fontColor.shade800,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FlatButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          onPressed: () => Share.share(
            'Hey, check out my app, COVID19 Info. Its a beautiful app that shows current infection status state-wise and India as a whole. https://bit.ly/2XXGklQ',
          ),
          icon: Icon(
            mdicons.MaterialIcons.share,
            color: fontColor,
          ),
          label: Text(
            'Share App',
            style: TextStyle(color: fontColor, fontSize: 17),
          ),
        )
      ],
    ),
  );
}

class ThemePicker extends StatefulWidget {
  ThemePicker({Key key}) : super(key: key);

  @override
  _ThemePickerState createState() => _ThemePickerState();
}

class _ThemePickerState extends State<ThemePicker> {
  @override
  Widget build(BuildContext context) {
    void changeColor(Color color) => setState(
          () {
            customColor = color;
            primaryColor = colorConv(43);
            secondaryColor = colorConv(80);
            thirdColor = colorConv(65);
            setStoredPrefs(customColor.value, null);
            reloadApp();
          },
        );
    return BlockPicker(
      pickerColor: customColor,
      onColorChanged: changeColor,
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void reloadApp() {
  runApp(
    new MaterialApp(
      home: new StateWise(),
    ),
  );
}
