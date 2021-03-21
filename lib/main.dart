import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqttdashboard/globals.dart';
import 'package:mqttdashboard/widgets/GaugeStone.dart';
import 'package:mqttdashboard/widgets/StoneCard.dart';
import 'package:mqttdashboard/widgets/TextStone.dart';

import 'StoneCollections.dart';

Future main() async {
  //mqttClient.resubscribeOnAutoReconnect = true;
  //mqttClient.onConnected = () => isConnected = true;
  //mqttClient.onDisconnected = () => isConnected = false;
  mqttClient.logging(on: true);
  await mqttClient.connect();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTheme,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(width: 200, height: 200,child: GaugeStone("Luftfuktighet","homey/livingroomsensor/measure-temperature", valuePostfix: " %",min: 10, max: 40,)),
            StoneCard(Column(
              children: [
              StoneCard(Padding(padding: EdgeInsets.all(30),child: Text("Luftfuktigheten ble normal igjen kl 20.47", style: h3,textAlign: TextAlign.center,))),
              StoneCard(Padding(padding: EdgeInsets.all(30),child: Text("Advarsel: Luftfuktigheten oversteg 80% kl. 20.23!", style: h3,textAlign: TextAlign.center,)))
            ],))
          ],
        )/*WallLayout(
          stones: LivingRoomStones,
          layersCount: 2,

        ),*/
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