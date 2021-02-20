// This example makes a [Container] react to being entered by a mouse
// pointer, showing a count of the number of entries and exits.

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';

List<FileSystemEntity> filterHiddenDir(List<FileSystemEntity> origin) {
  List<FileSystemEntity> proposed = new List();
  if (Platform.isMacOS || Platform.isLinux) {
    origin.forEach((element) {
    if (!basename(element.path).startsWith(".")) {
      proposed.insert(0, element);
    }
    });
  } else if (Platform.isWindows) {

  } else {
    proposed = origin;
  }
  return proposed;
}

class FileSelectorWidget extends StatelessWidget {  
  final arguments;
  FileSelectorWidget({ this.arguments });

  @override
  Widget build(BuildContext context) {
    Directory dir = Directory(this.arguments["path"]);
    List<FileSystemEntity> entities = dir.listSync(recursive: false);
    entities = filterHiddenDir(entities);
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments["path"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.separated(
                  itemCount: entities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: entities[index] is File? Colors.blue[100]: Colors.red[100],
                      ),
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: double.infinity, minHeight: 50),
                              child: FlatButton(
                                child: Text(
                                  "${entities[index].path}",
                                ),
                                onPressed: () {
                                  if (entities[index] is File) {
                                    Navigator.pushNamed(context, "/analysis", arguments: {
                                      "path": entities[index].path,
                                      "status": "waiting",
                                    });
                                  } else {
                                    Navigator.pushNamed(context, "/file_selector", arguments: {
                                      "path": entities[index].path
                                    });
                                  }
                                },
                              ),
                            )
                          ),
                          Expanded(flex: 1, child: FlatButton(child: Text(entities[index] is File? "Select": "==>"), onPressed: () {
                            if (entities[index] is File) {
                              Navigator.pushNamed(context, "/analysis", arguments: {
                                "path": entities[index].path,
                                "status": "waiting",
                              });
                            } else {
                              Navigator.pushNamed(context, "/file_selector", arguments: {
                                "path": entities[index].path,
                              });
                            }
                          }))
                        ]
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                )
              ),
            ],
          )
        ),
      ),
    );
  }
}