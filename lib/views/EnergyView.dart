import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mqttdashboard/globals.dart';
import 'package:mqttdashboard/main.dart';

String url = "https://my.homey.app/homeys/5ff832d7994cd20b7e4addec/energy";

class EnergyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MyApp(
      WebviewScaffold(
        url: url,
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