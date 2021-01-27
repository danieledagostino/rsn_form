import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';

class RsnFeedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _getResources(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          //if connectionstate.done
          if (snapshot.hasData) {
            log('data loaded', level: 2);
            var jsonData = jsonDecode(snapshot.data);
            jsonData = jsonData['graphql']['user']
                ['edge_owner_to_timeline_media']['edges'];
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: jsonData
                    .map<Widget>(
                        (e) => _getCard(PostModel.fromData(e), context))
                    .toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Loading timeout!'));
          } else {
            return Center(child: Text('Loading feeds...'));
          }
        });
  }

  InkWell _getCard(PostModel model, BuildContext ctx) {
    return InkWell(
        onTap: () => {},
        child: Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.green, spreadRadius: 1),
            ],
          ),
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(ctx).size.width,
          child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5.0),
              child: Image.network(
                model.imageUrl,
                width: 80,
                height: 80,
                errorBuilder: (context, error, stackTrace) {
                  log('error while loading image url in feeds');
                  return Icon(Icons.details);
                },
              ),
            ),
            Flexible(
              child: Text(
                model.description,
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.fade,
                softWrap: true,
                maxLines: 4,
              ),
            ),
          ]),
        ));
  }

  Future<String> _getResources() async {
    var jsonContent;
    var url = 'https://www.instagram.com/rsn_uk/?__a=1';
    if (kDebugMode) {
      await rootBundle
          .loadString(join('test_resources', 'ig_test.json'))
          .then((value) => jsonContent = value)
          .catchError((error) {
        stderr.writeln('Exception during ig_test.json');
        throw ('file not found');
      });
    } else {
      var res =
          await http.get(url).timeout(Duration(seconds: 20)).catchError((e) {
        log('Exception during widget_conf.json\n' + e.message,
            level: 5, error: e);
        stderr.writeln('Exception during widget_conf.json\n' + e.message);
      });
      if (res != null && res.statusCode == 200) {
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
