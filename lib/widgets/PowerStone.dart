import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  String cost = "8.4";

  double currently;

  PowerStoneState() {
    subscribe("tibbers", (payload) {});
    /*  var response = json.decode(payload);
      var res = response["viewer"];
      var homes = res["homes"];
      var home = homes[0];
      var cons = home["consumption"];
      var conKeys = cons.keys();
      var nodes = home["nodes"];
      var nodesKeys = nodes.keys();
      var node = nodes[0];
      var data = response["viewer"]["homes"][0]["consumption"]["nodes"][0];
      setState(() {
        powerYesterday=data["consumption"];
        unit = data["consumptionUnit"];
        cost = data["cost"];
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return StoneCard(Text(
      "Strøm i går: $powerYesterday $unit ($cost kr)"
    ,style: h3,));
  }

}