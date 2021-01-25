import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'package:rsn_form/model/app_conf.dart';
import 'package:rsn_form/model/hub.dart';
import 'package:rsn_form/pages/rsn_settings.dart';
import 'package:rsn_form/pages/rsn_stepper.dart';

class RsnDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: FutureBuilder<String>(
            future: _getHub(),
            builder: (ctx, a) {
              if (a.hasData) {
                return ListView(children: <Widget>[
                  Container(
                    color: Colors.green,
                    height: 80.0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: DrawerHeader(
                          margin: EdgeInsets.all(0.0),
                          padding: EdgeInsets.all(0.0),
                          child: Column(children: [
                            Text("Jhon Smith"),
                            Text(a.data),
                          ]),
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RsnSettings()));
                      //Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add_chart),
                    title: Text('Feedback form'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RsnStepper()));
                      //Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Calendar'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Security number'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ]);
              } else {
                return Container();
              }
            }));
  }

  Future<String> _getHub() async {
    List<AppConf> list = await GetIt.I.get<IAppConfDao>().findByKey('ownHub');
    if (list.isNotEmpty) {
      Hub h = list[0].value as Hub;
      return h.name + ' hub';
    } else {
      return 'no hub selected yet';
    }
  }
}
