import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall_layout/layout/stone.dart';
import 'package:mqttdashboard/mqtt.dart';
import 'package:mqttdashboard/widgets/ButtonStone.dart';
import 'package:mqttdashboard/widgets/GaugeStone.dart';
import 'package:mqttdashboard/widgets/PowerStone.dart';
import 'package:mqttdashboard/widgets/StoneCard.dart';
import 'package:mqttdashboard/widgets/TextStone.dart';
import 'package:mqttdashboard/widgets/light_slider.dart';

import 'globals.dart';

var LivingRoomStones = [
  createStone(child: PowerStone(),width: 1, height: 1,),
  createStone(child: GaugeStone("Temperature","homey/livingroomsensor/measure-temperature", valuePostfix: " °C",min: 10, max: 40,),width: 1, height: 1,),

  //Lights
  createStone(child: LightSlider("hallway"),width: 1, height: 1,),
  createStone(child: LightSlider("living room"),width: 1, height: 1,),


  //Flows
  createStone(child: ButtonStone(scalingIcon(Icons.night_shelter),flowsTopic+"GodNatt"),width: 1, height: 1,),
  createStone(child: ButtonStone(scalingIcon(Icons.house),flowsTopic+"Home"),width: 1, height: 1,),

];

int nextId = 0;

Stone createStone({int width, Widget child, int height}) {
  nextId++;
  return Stone(id: nextId, child: child, width: width, height: height);
}

Widget scalingIcon(IconData data) {
return new LayoutBuilder(builder: (context, constraint) =>
  new Icon(data, size: constraint.biggest.height)
);
}