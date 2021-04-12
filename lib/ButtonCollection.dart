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

Widget NightToggle() => StoneToggle(
  child: Icon(Icons.nightlight_round, color: Colors.white,),
);