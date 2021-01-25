import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rsn_form/pages/rsn_settings.dart';

class RsnAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  RsnAppBar(
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
      automaticallyImplyLeading: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {
            // do something
          },
        ),
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => RsnSettings())),
        ),
      ],
    );
  }
}
