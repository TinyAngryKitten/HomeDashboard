import 'package:flutter/material.dart';
import 'package:mqttdashboard/globals.dart';
import 'package:mqttdashboard/widgets/ButtonStone.dart';
import 'package:mqttdashboard/widgets/StoneToggle.dart';

Widget NightButton() => ButtonStone(
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Icon(Icons.nightlight_round, color: Colors.white,),
    Text("Night", style: h3,)
],),
"flows/godnight"//this cant be right
);

Widget HomeButton() => ButtonStone(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.house, color: Colors.white,),
        Text("Home", style: h3,)
      ],),
    "flows/godnight"//this cant be right
);

Widget NightToggle() => StoneToggle(
  onChild: Icon(Icons.nightlight_round, color: Colors.white,),
  offChild: Icon(Icons.wb_sunny, color: Colors.white,),
  topic: "",
);

Widget HomeToggle() => StoneToggle(
  onChild: Icon(Icons.house, color: Colors.white,),
  offChild: Icon(Icons.directions_walk, color: Colors.white,),
  topic: "",
);

Widget SensorToggle() => StoneToggle(
  onChild: Icon(Icons.notifications_active, color: Colors.white,),
  offChild: Icon(Icons.notifications_off, color: Colors.white,),
  topic: "",
);
