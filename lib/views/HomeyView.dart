import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../globals.dart';
import '../main.dart';

class HomeyView extends StatelessWidget {
  String _url = "https://my.homey.app/";

  @override
  Widget build(BuildContext context) => MyApp(
      WebviewScaffold(
        url: _url,
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