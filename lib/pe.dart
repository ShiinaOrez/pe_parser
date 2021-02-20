// This example makes a [Container] react to being entered by a mouse
// pointer, showing a count of the number of entries and exits.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';

Widget expansionTileFromJSON(dynamic data, String t) {
  if (data is Map<String, dynamic>) {
    List<Widget> tileChildren = new List<Widget>();
    data.forEach((key, value) {
      tileChildren.add(expansionTileFromJSON(value, key));
    });
    return ExpansionTile(
      title: Text(t),
      children: tileChildren,
    );
  } else if (data is List<dynamic>) {
    List<Widget> tileChildren = new List<Widget>();
    for (var i = 0; i < data.length; i++) {
      tileChildren.add(expansionTileFromJSON(data[i], "$i"));
    }
    return ExpansionTile(
      title: Text(t),
      children: tileChildren,
    );
  } else {
    print("$t: ${data.runtimeType.toString()}");
    return ExpansionTile(
      title: Text(t),
      children: [
        Container(height: 30, child: Text("$data"),)
      ], 
    );
  }
}

class PeWidget extends StatelessWidget {
  static const ch = MethodChannel("shiina/orez");
  static Future<String> analysis(String path) async {
    final String value = await ch.invokeMethod('analysis', {
      "filePath": path,
    });
    return value;
  }

  final arguments;
  PeWidget({ this.arguments });

  @override
  Widget build(BuildContext context) {
    if (this.arguments["status"] == "waiting") {
      String filename = basename(this.arguments['path']);
      analysis(this.arguments["path"])
        .then((value) {
          Navigator.popAndPushNamed(context, "/analysis", arguments: {
            "status": "done",
            "value": value,
            "fileName": filename,
          });
        });
      return Scaffold(
        appBar: AppBar(
          title: Text("Waiting... "),
        ),
      );
    } else if (this.arguments["status"] == "done") {
      final Map<String, dynamic> data = json.decode(this.arguments["value"]);
      if (data.containsKey("error_msg")) {
        return AlertDialog(
          title: Text("Error occur!!! "),
          content: Text("Error type is: ${data["type"]}, description is ${data["error_msg"]}. "),
          actions: <Widget>[
            FlatButton(
              child: Text("Close and Reselect"),
              onPressed: () => Navigator.of(context).pop(), //关闭对话框
            ),
          ],
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("PE Structure of: ${this.arguments["fileName"]}"),
        ),
        body: ListView(
          children: <Widget>[
            expansionTileFromJSON(data, this.arguments["fileName"]),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Something wrong... "),
      ),
    );
  }
}
