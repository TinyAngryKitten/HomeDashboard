import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mqttdashboard/globals.dart';

class ConnectionIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConnectionIndicatorState();
  }
}

class ConnectionIndicatorState extends State<ConnectionIndicator> {
  IconData currentIcon = Icons.signal_wifi_off;
  ReactionDisposer reactionDisposer;

  ConnectionIndicatorState() {
    changeIcon(isConnected.value);
    reactionDisposer = reaction((_) => isConnected.value, (state) => setState(() {
      changeIcon(state);
    }));
  }

  void changeIcon(bool state) {
    if(state) currentIcon = Icons.signal_wifi_4_bar;
    else currentIcon = Icons.signal_wifi_off;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(currentIcon, color: Colors.white,);
  }

  @override
  void dispose() {
    super.dispose();

  }

}