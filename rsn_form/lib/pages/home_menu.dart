import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsn_form/widget/hub_dropdownlist.dart';
import 'package:rsn_form/widget/menu_button.dart';
import 'package:rsn_form/pages/rsn_stepper.dart';
import 'package:path/path.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('RSN'),
        ),
        body: FutureBuilder<String>(
            future: rootBundle.loadString(join('resources', 'hubs.json')),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      HubDropdownlist(snapshot.data),
                      MenuButton(
                          label: 'Settings',
                          buttonIcon: Icons.settings,
                          backgroundColor: Colors.red,
                          onPressed: () => {}),
                      MenuButton(
                          label: 'Feedback form',
                          buttonIcon: Icons.android,
                          backgroundColor: Colors.blue,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RsnStepper()))),
                      MenuButton(
                          label: 'Calendar',
                          buttonIcon: Icons.calendar_today,
                          backgroundColor: Colors.yellow,
                          onPressed: () => {}),
                      MenuButton(
                          label: 'Safeguarding number',
                          buttonIcon: Icons.phone,
                          backgroundColor: Colors.pink,
                          onPressed: () => {}),
                    ],
                  ),
                ));
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
            }));
  }
}
