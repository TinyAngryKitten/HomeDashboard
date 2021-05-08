import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobx/mobx.dart';
import 'package:mqttdashboard/globals.dart';

import 'PhoneApp.dart';
import 'package:flutter/services.dart';

Future main() async {
  //disable strict mode to allow changing observables
  mainContext.config = ReactiveConfig.main.clone(writePolicy: ReactiveWritePolicy.never);

  mqttClient.autoReconnect = true;
  mqttClient.resubscribeOnAutoReconnect = true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  mqttClient.onConnected = () => isConnected.value = true;
  mqttClient.onDisconnected = () => isConnected.value = false;
  mqttClient.connect();

  runApp(PhoneApp());
}

class MyApp extends StatelessWidget {
  Widget _child;
  MyApp(this._child);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
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