import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqttdashboard/globals.dart';
import 'package:mqttdashboard/widgets/GaugeStone.dart';
import 'package:mqttdashboard/widgets/StoneCard.dart';
import 'package:mqttdashboard/widgets/TextStone.dart';

import 'StoneCollections.dart';

Future main() async {
  mqttClient.resubscribeOnAutoReconnect = true;
  mqttClient.onConnected = () => isConnected = true;
  mqttClient.onDisconnected = () => isConnected = false;
  await mqttClient.connect();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'Flutter Demo',
      //theme: defaultTheme,
      home: Scaffold(
        appBar: NeumorphicAppBar(
          title: Center(
              child: NeumorphicText("Livingroom",style: NeumorphicStyle(shadowLightColor: softShadowColor,shadowDarkColor: shadowColor, depth: 20),)),
          color: backgroundColor,
        ),
        body: Container(
          color: backgroundColor,
            child: Column(
          children:
            [
              WallLayout(layersCount: 2, stones: LivingRoomStones,)
            ],),
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}