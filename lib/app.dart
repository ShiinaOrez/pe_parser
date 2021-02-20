// This example makes a [Container] react to being entered by a mouse
// pointer, showing a count of the number of entries and exits.

import 'package:flutter/material.dart';

import 'package:pe_parser/file_selector.dart';
import 'package:pe_parser/pe.dart';
import 'package:pe_parser/shiina.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for widgets.Listener',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.pink,
      ),
      home: ShiinaWidget(),
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == "/file_selector") {
          return new MaterialPageRoute(
            builder: (context) => FileSelectorWidget(arguments: routeSettings.arguments)
          );
        }
        if (routeSettings.name == "/analysis") {
          return new MaterialPageRoute(
            builder: (context) => PeWidget(arguments: routeSettings.arguments)
          );
        }
        return new MaterialPageRoute(
          builder: (context) => ShiinaWidget()
        );
      }
    );
  }
}

