import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../mqtt.dart';

class LightSlider extends StatefulWidget {
  String topic;

  LightSlider(String lightName, {Key key}) : super(key: key) {
    topic = "light/group/" + lightName + "/";
  }

  @override
  _LightSliderState createState() => _LightSliderState();
}

class _LightSliderState extends State<LightSlider> {
  double _value = 2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FlutterSlider(
        axis: Axis.vertical,
        values: [_value],
        tooltip: FlutterSliderTooltip(disabled: true),
        onDragging: (int newValue, arg2, arg3) {
          setState(() {
            _value = arg2.roundToDouble();
          });
        },
        onDragCompleted: (int newValue, arg2, arg3) {
          publish(widget.topic + "brightness", arg2.round().toString());
          setState(() {
            _value = arg2.roundToDouble();
          });
        },
        min: 0.0,
        max: 100.0,
      );
    });
  }
}
