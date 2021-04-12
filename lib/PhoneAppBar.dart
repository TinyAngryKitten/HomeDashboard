import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqttdashboard/widgets/AppBarStat.dart';
import 'package:mqttdashboard/widgets/ConnectionIndicator.dart';

import 'globals.dart';

class PhoneAppBar extends StatelessWidget {
  final String room;

  PhoneAppBar(this.room);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        child: Row(
      children: [
        ConnectionIndicator(),
        Expanded(child: buildTitle()),
        AppBarStat("homey/livingroomsensor/measure-temperature", "°C"),
        AppBarStat("homey/livingroomsensor/measure-humidity", "%"),
      ],
    ))  ;
  }

  // ignore: missing_return
  Widget buildTitle() {
    return NeumorphicText(
      room,
      style: NeumorphicStyle(
          shadowLightColor: softShadowColor,
          shadowDarkColor: shadowColor,
          depth: 20,
          color: Colors.white,
          lightSource: neuTheme.lightSource
      ),
      textStyle: NeumorphicTextStyle(fontSize: 20),
    );
  }
}