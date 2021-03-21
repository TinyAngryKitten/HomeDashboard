import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall_layout/layout/stone.dart';
import 'package:mqttdashboard/mqtt.dart';
import 'package:mqttdashboard/widgets/ButtonStone.dart';
import 'package:mqttdashboard/widgets/GaugeStone.dart';
import 'package:mqttdashboard/widgets/PowerStone.dart';
import 'package:mqttdashboard/widgets/StoneCard.dart';
import 'package:mqttdashboard/widgets/TextStone.dart';

import 'globals.dart';

var LivingRoomStones = [
  //Stone(id: 1, child: PowerStone(),width: 1, height: 1,),
  //Stone(id: 2, child: GaugeStone("Temperature","homey/livingroomsensor/measure-temperature", valuePostfix: " °C",min: 10, max: 40,),width: 1, height: 1,),

  Stone(id: 1, child: GaugeStone("Luftfuktighet","homey/livingroomsensor/measure-temperature", valuePostfix: " %",min: 10, max: 40,), width: 1, height: 1,),
  Stone(id: 2, child: StoneCard(Padding(padding: EdgeInsets.only(left: 50),child: Text("Advarsel: Luftfuktigheten oversteg 80% kl. 20.23!", style: h2,))), width: 2, height: 1)
  //Flows
  //Stone(id: 3, child: ButtonStone(scalingIcon(Icons.night_shelter),flowsTopic+"GodNatt"),width: 1, height: 1,),
  //Stone(id: 4, child: ButtonStone(scalingIcon(Icons.house),flowsTopic+"Home"),width: 1, height: 1,),

];

Widget scalingIcon(IconData data) {
return new LayoutBuilder(builder: (context, constraint) =>
  new Icon(data, size: constraint.biggest.height)
);
}