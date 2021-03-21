import 'package:flutter/cupertino.dart';
import 'package:mqttdashboard/mqtt.dart';
import 'package:mqttdashboard/widgets/StoneCard.dart';

import '../globals.dart';

class TextStone extends StatefulWidget {
  final String topic;
  final Function buildString;
  final TextStyle style;
  TextStone(this.topic, this.buildString, {this.style=h2});

    @override
  State<StatefulWidget> createState() {
    return TextStoneState(topic,buildString,style: style);
  }

}

class TextStoneState extends State<TextStone> {
  final String topic;
  final Function buildString;
  final TextStyle style;
  var text = "";
  TextStoneState(this.topic, this.buildString, {this.style=h2}) {
    subscribe(topic, (String payload) => setState(() {
      text = buildString(payload);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return StoneCard(
        Text(
          text,
          style: style,
        )
    );
  }

}