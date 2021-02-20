// This example makes a [Container] react to being entered by a mouse
// pointer, showing a count of the number of entries and exits.

import 'package:flutter/material.dart';
import 'dart:io';

String os = Platform.operatingSystem;
Map<String, String> envVars = Platform.environment;
final home = Platform.isMacOS || Platform.isLinux? envVars['HOME']: Platform.isWindows? envVars["UserProfile"]: "/";

class ShiinaWidget extends StatefulWidget {
  ShiinaWidget({Key key}): super(key: key);
  @override
  _ShiinaWidget createState() => _ShiinaWidget();
}

class _ShiinaWidget extends State<ShiinaWidget> {
  String filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PE File Parser'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink[100]
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: double.infinity,
                        minWidth: double.infinity,
                      ),
                      child: FlatButton(
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        child: Text(
                          "Select File",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.pink,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/file_selector", arguments: {
                            "path": home,
                          });
                        },
                      ),
                    )
                  ),
                )
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: 10
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink[200]
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: double.infinity,
                        minWidth: double.infinity,
                      ),
                      child: Center(child: Text("Powered by @Shiina Orez\nDev: @Dart @Flutter @Go")),
                    ),
                  ),
                )
              ),
            ],
          )
        ),
      ),
    );
  }
}
