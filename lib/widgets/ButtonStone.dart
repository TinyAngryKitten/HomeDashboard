import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqttdashboard/widgets/StoneCard.dart';

import '../globals.dart';
import '../mqtt.dart';

class ButtonStone extends StatelessWidget {
  final Widget child;
  final String topic;
  final String msg;

  ButtonStone(this.child, this.topic, { this.msg = ""});
  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    return NeumorphicButton(
      style: NeumorphicStyle(
          lightSource: theme.lightSource,
          color: backgroundColor,
          shadowDarkColor: theme.shadowDarkColor,
          shadowLightColor: theme.shadowLightColor,
          depth: theme.depth,
          intensity: theme.intensity
      ),
          child: child,
          onPressed: onClick,
    );
  }

  void onClick() {
    publish(topic,msg);
  }
}