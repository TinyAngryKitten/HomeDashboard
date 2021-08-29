import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mqttdashboard/globals.dart';
import 'package:mqttdashboard/main.dart';

String statsUrl = "https://www.google.com";

class StatsScreen extends StatelessWidget {

  StatsScreen() {
  }

  @override
  Widget build(BuildContext context) => MyApp(
      WebviewScaffold(
        url: statsUrl,
        appBar: new AppBar(
          backgroundColor: backgroundColor,
          leading: exitButton(context),
        ),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          color: backgroundColor,
        ),
      )
  );

  Widget exitButton( BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Icon(
        Icons.close,
        color: Colors.white,
      ),
    );
  }
}
