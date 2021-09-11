import 'dart:ffi';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqttdashboard/widgets/AppBarStat.dart';
import 'package:mqttdashboard/widgets/ConnectionIndicator.dart';

import 'data/Room.dart';
import 'data/Rooms.dart';
import 'globals.dart';

class PhoneAppBar extends StatelessWidget {
  final Room room;
  final Function onRoomChanged;
  PhoneAppBar(this.room, this.onRoomChanged);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
        child: Row(
      children: [
        ConnectionIndicator(),
        Expanded(child: Container()),
        buildRoomPicker(),
        Expanded(child: Container())
      ],
    ));
  }

  Widget buildRoomPicker() {
    return DropdownButton(
      underline: Container(),
      value: room,
      onChanged: (o) => onRoomChanged(o),
      items: rooms.values.map((Room r) => DropdownMenuItem<Room>(
        value: r,
        child: buildRoomName(r.name),
      )).toList()
    );
  }

  // ignore: missing_return
  Widget buildRoomName(String name) {
    return NeumorphicText(
      name,
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