import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';

class RsnFeedWidget extends StatelessWidget {
  bool _isDebug;

  RsnFeedWidget() {
    _isDebug = bool.fromEnvironment('dart.vm.product', defaultValue: false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _getResources(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            var jsonData = jsonDecode(snapshot.data);
            jsonData = jsonData['graphql']['user']
                ['edge_owner_to_timeline_media']['edges'];
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: jsonData
                    .map<Widget>((e) => _getCard(PostModel.fromData(e)))
                    .toList(),
              ),
            );
          }
        });
  }

  SingleChildScrollView _getCard(PostModel model) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
          child: InkWell(
              onTap: () => {},
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Image.network(model.imageUrl, width: 100, height: 100),
                Text(model.description, style: TextStyle(color: Colors.black)),
                const SizedBox(width: 8),
              ]))),
    );
  }

  Future<String> _getResources() async {
    var jsonContent;
    var url = 'https://www.instagram.com/rsn_uk/?__a=1';
    if (true) {
      //_isDebug) {
      await rootBundle
          .loadString(join('test_resources', 'ig_test.json'))
          .then((value) => jsonContent = value)
          .catchError((error) {
        stderr.writeln('Exception during ig_test.json');
        throw ('file not found');
      });
    } else {
      var res = await http.get(url).catchError((e) {
        stderr.writeln('Exception during widget_conf.json\n' + e.toString());
      });
      if (res.statusCode == 200) {
        jsonContent = res.body;
      } else {
        stderr.writeln('resource not available: ' + res.statusCode.toString());
      }
    }
    return jsonContent;
  }
}

class PostModel {
  //data['graphql']['users']['edge_owner_to_timeline_media']['edges']
  final String description;
  final String imageUrl;

  PostModel(this.imageUrl, this.description);

  factory PostModel.fromData(dynamic data) {
    final String imageUrl = data['node']['display_url'];
    final description =
        data['node']['edge_media_to_caption']['edges'][0]['node']['text'];
    return PostModel(imageUrl, description);
  }
}
