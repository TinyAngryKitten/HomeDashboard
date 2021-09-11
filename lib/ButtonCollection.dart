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
"action/God natt"
);

Widget HomeButton() => ButtonStone(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.house, color: Colors.white,),
        Text("Home", style: h3,)
      ],),
    "action/Home"
);

Widget ACButton() => ButtonStone(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.ac_unit_rounded, color: Colors.white,),
        Text("AC", style: h3,)
      ],),
    "action/toggleAc"
);

Widget NightToggle() => StoneToggle(
  onChild: Icon(Icons.nightlight_round, color: Colors.white,),
  offChild: Icon(Icons.wb_sunny, color: Colors.white,),
  publishTopic: "state/update/boolean/Night",
  subscribeTopic: "state/Night",
);

Widget HomeToggle() => StoneToggle(
  onChild: Icon(Icons.house, color: Colors.white,),
  offChild: Icon(Icons.directions_walk, color: Colors.white,),
  publishTopic: "state/update/boolean/Home",
  subscribeTopic: "state/Home",
);

Widget SensorToggle([String room = ""]) => StoneToggle(
  onChild: Icon(Icons.notifications_active, color: Colors.white,),
  offChild: Icon(Icons.notifications_off, color: Colors.white,),
  publishTopic: "state/update/boolean/Motion$room",
  subscribeTopic: "state/Motion$room",
);
