import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return StoneCard(
        MaterialButton(
          child: child,
          onPressed: onClick,
        )
    );
  }

  void onClick() {
    publish(topic,msg);
  }
}