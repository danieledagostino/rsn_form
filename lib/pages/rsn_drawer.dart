import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'package:rsn_form/model/app_conf.dart';
import 'package:rsn_form/model/hub.dart';
import 'package:rsn_form/pages/rsn_settings.dart';
import 'package:rsn_form/pages/rsn_stepper.dart';

class RsnDrawer extends StatelessWidget {
  String _noHubMsg = 'no hub selected yet';

  @override
  Widget build(BuildContext context) {
    TextStyle fontStyle = TextStyle(
        fontSize: 20, color: Colors.brown, fontWeight: FontWeight.bold);
    return Drawer(
        child: FutureBuilder<String>(
            future: _getHub(),
            builder: (ctx, a) {
              if (a.hasData) {
                return ListView(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("resources/thankyou.jpg"),
                          fit: BoxFit.fill),
                    ),
                    height: 80.0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: DrawerHeader(
                        margin: EdgeInsets.all(0.0),
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            verticalDirection: VerticalDirection.down,
                            children: [
                              Text(
                                "Jhon Smith",
                                style: fontStyle,
                                textAlign: TextAlign.left,
                              ),
                              Text(a.data,
                                  style: fontStyle, textAlign: TextAlign.left),
                            ]),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RsnSettings()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add_chart),
                    title: Text('Feedback form'),
                    onTap: () {
                      if (a.data != _noHubMsg) {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RsnStepper()));
                      } else {
                        Navigator.pop(context);
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Please select your Hub in settings first!')));
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Calendar'),
                    onTap: () {
                      Navigator.pop(context);
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Not implemented yet!')));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Safeguarding number'),
                    onTap: () {
                      Navigator.pop(context);
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Not implemented yet!')));
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
      return _noHubMsg;
    }
  }
}
