import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:mqttdashboard/globals.dart';
import 'package:mqttdashboard/views/TvRemote.dart';

import 'PhoneApp.dart';
import 'StoneCollections.dart';

Future main() async {
  mqttClient.autoReconnect = true;
  mqttClient.resubscribeOnAutoReconnect = true;
  //mqttClient.onConnected = () => isConnected.value = true;
  //mqttClient.onDisconnected = () => isConnected.value = false;
  mqttClient.connect();

  runApp(PhoneApp());
}

class MyApp extends StatelessWidget {
  Widget _child;
  MyApp(this._child);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      theme: neuTheme,
      home: Scaffold(
        body: Container(
          color: backgroundColor,
            child: _child
        )
      ),
    );
  }
}