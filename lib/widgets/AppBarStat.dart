import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../globals.dart';
import '../mqtt.dart';
import 'StoneCard.dart';

class AppBarStat extends StatefulWidget {
  final String topic;
  final String postfix;
  final int depth;

  AppBarStat(this.topic, this.postfix, {this.depth});

  @override
  State<StatefulWidget> createState() {
    return AppBarStatState(topic);
  }
}

class AppBarStatState extends State<AppBarStat> {
  String value = "–";

  AppBarStatState(String topic){
    subscribe(topic, (value) {
      setState(() {
        value = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return
      StoneCard(
        Container(
          padding: EdgeInsets.all(7),
          child: Center(
          child: Text(
              "$value ${widget.postfix}",
            style: h3,
          )),
      ),
    );
  }

}