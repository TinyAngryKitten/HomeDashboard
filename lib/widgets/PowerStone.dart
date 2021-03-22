import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqttdashboard/widgets/StoneCard.dart';

import '../globals.dart';
import '../mqtt.dart';

class PowerStone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PowerStoneState();
  }
}

class PowerStoneState extends State<PowerStone> {

  double powerYesterday = 300;
  String unit = "kWh";
  double cost = 8.4;

  double currently;

  PowerStoneState() {
    subscribe("tibbers", (String payload) {
      setState(() {
        powerYesterday = double.parse(findStringInJson(payload, "consumption")).roundToDouble();
        unit = findStringInJson(payload,"consumptionUnit");
        cost = double.parse(findStringInJson(payload,"cost")).roundToDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoneCard(Text(
      "Strøm i går: $powerYesterday $unit ($cost kr)"
    ,style: h3,));
  }

  //a bit tibber specific
  String findStringInJson(String data, String str) {
    int startPosition = data.lastIndexOf("\"$str\":"); //the value is a number
    String subStr = data.substring(startPosition+"\"$str\":".length);
    if(subStr.startsWith("\"")) subStr = subStr.substring(1);
    return subStr.characters.takeWhile((s) => s != '"' && s != ',' && s != '}').string;
  }
}